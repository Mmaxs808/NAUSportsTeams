from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import pandas as pd

cService = webdriver.ChromeService(executable_path='C:\Program Files (x86)\chromedriver.exe')
driver = webdriver.Chrome(service=cService)
driver_link_list = ["https://nauathletics.com/sports/mens-basketball/stats/2023-24",
                     "https://nauathletics.com/sports/womens-basketball/stats/2023-24"]

# Making DF
Players = pd.DataFrame()

for link in driver_link_list:
    # Opening Driver
    driver.get(link)
    driver.implicitly_wait(10)

    # Getting Dropdown Info
    dropdown = driver.find_element(By.XPATH, "/html/body/form/main/article/div[2]/ul[2]/li/select")
    dd_items = dropdown.find_elements(By.TAG_NAME, "option")
    dd_items = dd_items[1:]

    # Loop
    dropdownIndex = 1
    year = 2024

    for obj in dd_items:
        # Going to next element in dropdown
        select = Select(driver.find_element(By.XPATH, "/html/body/form/main/article/div[2]/ul[2]/li/select"))
        select.select_by_index(dropdownIndex)
        dropdownIndex += 1

        # Changing Pages
        select = Select(driver.find_element(By.XPATH, "/html/body/form/main/article/div[3]/header/select"))
        select.select_by_value("#individual")
        
        select = Select(driver.find_element(By.XPATH, "/html/body/form/main/article/div[3]/section[2]/header/select"))
        select.select_by_value("#individual-averages")

        # Making index and other variables
        side_index = 1
        down_index = 1
        down_available = True
        Players_that_season = pd.DataFrame()

        # Loop through pages
        while down_available:
            if link == driver_link_list[0]:
                data = {"Team": ["Mens"]}
            else:
                data = {"Team": ["Womens"]}

            #Adding to df
            working_df = pd.DataFrame.from_dict(data)
            working_df.index = [year]

            while side_index <= 14:
                # Check Label Link
                if side_index <= 3:
                    label_link = "/html/body/form/main/article/div[3]/section[2]/section[4]/div/div/table/thead/tr[1]/th[{}]".format(side_index)
                else:
                    label_link = "/html/body/form/main/article/div[3]/section[2]/section[4]/div/div/table/thead/tr[2]/th[{}]".format(side_index - 3)

                # Check Value Link
                if side_index == 2:
                    value_link = "/html/body/form/main/article/div[3]/section[2]/section[4]/div/div/table/tbody/tr[{}]/td[2]/a".format(down_index)
                else:
                    value_link = "/html/body/form/main/article/div[3]/section[2]/section[4]/div/div/table/tbody/tr[{down}]/td[{side}]".format(down = down_index, side = side_index)

                try:
                    value = driver.find_element(By.XPATH, value_link)
                except NoSuchElementException:
                    value_link = "/html/body/form/main/article/div[3]/section[2]/section[4]/div/div/table/tbody/tr[{}]/td[2]".format(down_index)

                label = driver.find_element(By.XPATH, label_link)
                value = driver.find_element(By.XPATH, value_link)
                working_df[label.text] = value.text

                side_index += 1
            
            # Fixing Indecies
            down_index += 1
            side_index = 1

            # Adding to Sub DF
            Players_that_season = pd.concat([Players_that_season, working_df])

            # Resetting DF
            del working_df

            # Checking to see if you can loop again
            try:
                value_link = "/html/body/form/main/article/div[3]/section[2]/section[4]/div/div/table/tbody/tr[{down}]/td[{side}]".format(down = down_index, side = side_index)
                value = driver.find_element(By.XPATH, value_link)
            except NoSuchElementException:
                down_available = False

        # Combining DFs
        Players = pd.concat([Players, Players_that_season])

        year -= 1

        del Players_that_season
     
driver.quit()

Players.to_csv('data/Players.csv', index = True)
