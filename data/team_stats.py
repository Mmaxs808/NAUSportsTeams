from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import pandas as pd

cService = webdriver.ChromeService(executable_path='C:\Program Files (x86)\chromedriver.exe')
driver = webdriver.Chrome(service=cService)
driver_link_list = ["https://nauathletics.com/sports/mens-basketball/stats/2023-24",
                    "https://nauathletics.com/sports/womens-basketball/stats/2023-24"]
coaches_link_list = ["https://nauathletics.com/sports/mens-basketball/coaches",
                     "https://nauathletics.com/sports/womens-basketball/coaches"]

# Making the DF
NAUBasketball= pd.DataFrame()

for link in driver_link_list:
    # Opening Driver
    driver.get(link)
    driver.implicitly_wait(2)

    # Grabbing Dropdown for loop
    dropdown = driver.find_element(By.XPATH, "/html/body/form/main/article/div[2]/ul[2]/li/select")
    dd_items = dropdown.find_elements(By.TAG_NAME, "option")
    dd_items = dd_items[1:]

    # Loop
    dropdownIndex = 1
    year = 2024

    for obj in dd_items:
        # Reprime index
        index = 2

        # Going to next element in dropdown
        select = Select(driver.find_element(By.XPATH, "/html/body/form/main/article/div[2]/ul[2]/li/select"))
        select.select_by_index(dropdownIndex)
        dropdownIndex += 1

        # Grabbing the team stats (total score at the top)
        team_stats = driver.find_element(By.XPATH, '/html/body/form/main/article/div[3]/section[1]/h2')
        team_stats_sep = team_stats.text.split('(')

        # Insert into df
        label = team_stats_sep[0]
        value = team_stats_sep[1].replace(')', '')
        data = {label: [value]}

        if link == driver_link_list[0]:
            data["Team"] = "Mens"
        else:
            data["Team"] = "Womens"

        #Adding to df
        working_df = pd.DataFrame.from_dict(data)
        working_df["Year"] = [year]
        year -= 1

        # Loop through rest of page
        while index <= 36:
            label_link = "/html/body/form/main/article/div[3]/section[1]/table/tbody/tr[{}]/td[1]/span[1]".format(index)
            value_link = "/html/body/form/main/article/div[3]/section[1]/table/tbody/tr[{}]/td[2]".format(index)

            # Checking if links are there
            try:
                label = driver.find_element(By.XPATH, label_link)
                value = driver.find_element(By.XPATH, value_link)
                working_df[label.text] = value.text
            except NoSuchElementException:
                pass
                
            index += 1

        # Combining DFs
        NAUBasketball = pd.concat([NAUBasketball, working_df])

        # Clearing working DF
        del working_df

#-------------------------------------------------------------------------------------------------------
        
# Grabbing Coaches Name
Coaches = pd.DataFrame()

for link in coaches_link_list:
    # Opening Driver
    driver.get(link)
    driver.implicitly_wait(5)

    # Getting Dropdown Info
    dropdown = driver.find_element(By.XPATH, "/html/body/form/main/article/header/div[2]/ul/li/select")
    dd_items = dropdown.find_elements(By.TAG_NAME, "option")
    dd_items = dd_items[:9]

    # Loop
    dropdownIndex = 0
    year = 2024

    for obj in dd_items:
        # Going to next element in dropdown
        select = Select(driver.find_element(By.XPATH, "/html/body/form/main/article/header/div[2]/ul/li/select"))
        select.select_by_index(dropdownIndex)
        dropdownIndex += 1
    
        if link == coaches_link_list[0]:
            data = {"Team": ["Mens"]}
        else:
            data = {"Team": ["Womens"]}
              
        # Checking if links are there
        label = driver.find_element(By.XPATH, "/html/body/form/main/article/table[1]/tbody/tr[1]/td[1]").text
        value = driver.find_element(By.XPATH, "/html/body/form/main/article/table[1]/tbody/tr[1]/th/a").text
        data = {label: [value]}

        #Adding to df
        working_df = pd.DataFrame.from_dict(data)
        working_df["Year"] = [year]
        year -= 1

        # Combining DFs
        Coaches = pd.concat([Coaches, working_df])

        # Clearing working DF
        del working_df


driver.quit()

# Saving Individual Data Frames
NAUBasketball.to_csv('data/NAUBasketball.csv', index = True)
Coaches.to_csv('data/Coaches.csv', index = True)

Team_Stats = pd.merge(NAUBasketball, Coaches, 'left', left_on = ["Year", "Team"], right_on = ["Year", "Team"])

Team_Stats.to_csv('data/Team_Stats.csv')
