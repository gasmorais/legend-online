package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.FarmLandInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmOperMenu extends Sprite implements Disposeable
   {
      
      private var _accelerateBtn:IconButton;
      
      private var _clearBtn:IconButton;
      
      private var _data:FarmLandInfo;
      
      private var _saleBtn:IconButton;
      
      public function FarmOperMenu()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _accelerateBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmLandItemAccelerateBtn");
         _accelerateBtn.tipData = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.accelerate");
         addChild(_accelerateBtn);
      }
      
      private function addEvent() : void
      {
         _accelerateBtn.addEventListener("click",__onAccelerateClick);
      }
      
      private function removeEvent() : void
      {
         _accelerateBtn.removeEventListener("click",__onAccelerateClick);
         if(_clearBtn)
         {
            _clearBtn.removeEventListener("click",__onClearClick);
         }
         if(_saleBtn)
         {
            _saleBtn.removeEventListener("click",onSaleBtnClick);
         }
      }
      
      private function __onAccelerateClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(_data)
         {
            if(_data.hasAccelerate)
            {
               _loc2_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.hasAccelerateTip");
               if(_data.pos >= 1000)
               {
                  _loc2_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.hasanimalAccelerateTip");
               }
               MessageTipManager.instance().show(_loc2_);
               dispose();
               return;
            }
            _loc3_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.accelerateTip",farmManager.model.acceleratePay);
            if(_data.pos >= 1000)
            {
               _loc3_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.animalccelerateTip",farmManager.model.acceleratePay);
            }
            SimpleAlertHelper.instance.data = [operResponse,9,_data];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc3_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",farmManager.model.acceleratePay);
         }
         dispose();
      }
      
      private function __onClearClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data)
         {
            _loc2_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.clearTip");
            SimpleAlertHelper.instance.data = [operResponse,10,_data];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
         }
         dispose();
      }
      
      private function operResponse(param1:Boolean, param2:Boolean, param3:int, param4:FarmLandInfo) : void
      {
         if(param1 && param4)
         {
            farmManager.sendFarmOper(param4.userId,param3,param4.pos,0,0,param2);
         }
      }
      
      private function get farmManager() : FarmManager
      {
         return FarmManager.instance;
      }
      
      public function get data() : FarmLandInfo
      {
         return _data;
      }
      
      public function set data(param1:FarmLandInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(data.pos >= 1000)
         {
            _saleBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmAnimalItemSaleBtn");
            _saleBtn.tipData = LanguageMgr.GetTranslation("star.view.StarIconView.sell");
            _saleBtn.addEventListener("click",onSaleBtnClick);
            addChild(_saleBtn);
            _accelerateBtn.x = 20;
         }
         else
         {
            _clearBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmLandItemClearBtn");
            _clearBtn.tipData = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.clear");
            _clearBtn.addEventListener("click",__onClearClick);
            addChild(_clearBtn);
            _accelerateBtn.x = 10;
         }
      }
      
      private function onSaleBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data)
         {
            _loc2_ = LanguageMgr.GetTranslation("farm.view.FarmOperMenu.animalClearTip",_data.cropTemp.SellGold);
            SimpleAlertHelper.instance.data = [operResponse,10,_data];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
         }
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7,false,false);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_accelerateBtn)
         {
            _accelerateBtn.dispose();
         }
         _accelerateBtn = null;
         if(_clearBtn)
         {
            _clearBtn.dispose();
         }
         _clearBtn = null;
         if(_saleBtn)
         {
            _saleBtn.dispose();
         }
         _saleBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

