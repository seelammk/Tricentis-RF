*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${demo_url}    https://demowebshop.tricentis.com/
${browser}     firefox

*** Keywords ***
wait and click
     [Arguments]   ${el_xpath}
     Wait Until Keyword Succeeds   9x   5s    click element    ${el_xpath}

I login into Tricentis application with "${username}" and "${pwd}"
    Go To   ${demo_url}
    click link     //a[contains(text(),'Log in')]
    input text      id:Email  ${username}
    input text      id:Password   ${pwd}
    wait and click   //input[contains(@value,'Log in')]

I add products into the cart
    wait and click   //a[contains(text(),'Books')]
    wait and click   //a[contains(@title,'Show details for Science')]
    wait and click   //input[contains(@value,'Add to cart')]

    wait and click   //a[contains(text(),'Computers')]
    wait and click   //a[contains(@title,'Show products in category Notebooks')]
    wait and click   //input[contains(@value,'Add to cart')]

I should be able to validate the total cart price
    wait and click   //span[normalize-space()='Shopping cart']
    wait and click   (//input[@type="checkbox" and @name="removefromcart"])[1]
    wait and click   (//input[@type="checkbox" and @name="removefromcart"])[2]
    execute javascript  window.scrollTo(0,window.scrollMaxY)
    wait until element is visible    //td[@class="cart-total-right"]//strong[text()="1600.00"]   60s

    click element     //input[@value='Update shopping cart']

*** Test Cases ***
Test automation Demo with Robot framework
    [Setup]   Open Browser  browser=${browser}
    Given I login into Tricentis application with "${username}" and "${pwd}"
    When I add products into the cart
    Then I should be able to validate the total cart price
    [Teardown]  Close Browser
