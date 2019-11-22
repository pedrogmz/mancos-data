-- ====================================================================================================================
-- Local function
-- ====================================================================================================================
function OpenShopMenu()
  ESX.UI.Menu.CloseAll()

  local elements = {
    { 
      label = _U('firstaid') .. '[' .. Config.Price['firstaid'] .. '$]',
      value = { name = 'firstaid',    price = Config.Price['firstaid'] } 
    }--[[,
    { 
      label = _U('bandage') .. '[' .. Config.Price['bandage'] .. '$]',
      value = { name = 'bandage', price = Config.Price['bandage'] }
    },
    { 
      label = _U('medkit') .. '[' .. Config.Price['medkit'] .. '$]',
      value = { name = 'medkit',    price = Config.Price['medkit'] } 
    },
    { 
      label = _U('vicodin') .. '[' .. Config.Price['vicodin'] .. '$]',
      value = { name = 'vicodin',    price = Config.Price['vicodin'] } 
    },
    { 
      label = _U('hydrocodone') .. '[' .. Config.Price['hydrocodone'] .. '$]',
      value = { name = 'hydrocodone',    price = Config.Price['hydrocodone'] } 
    },
    { 
      label = _U('morphine') .. '[' .. Config.Price['morphine'] .. '$]',
      value = { name = 'morphine',    price = Config.Price['morphine'] } 
    }]]--
  }

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
      title    = _U('drugstore'),
      align    = 'top-left',
      elements = elements
    }, function(data, menu)
      local element = data.current.value

      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
          title = _U('valid_this_purchase'),
          align = 'top-left',
          elements = {
            { label = _U('yes'), value = 'yes' },
            { label = _U('no'),  value = 'no'  }
          }
        }, function(data2, menu2)
          if data2.current.value == 'yes' then
            TriggerServerEvent('esx_pharmacy:buyItem', element.name, element.price)
          end
          
          menu2.close()
          setCurrentAction('pharmacy_shop', _U('press_menu'), {})
        end, function(data2, menu2)
          menu2.close()
        end
      )

    end, function(data, menu)
      menu.close()
    end
  )

end