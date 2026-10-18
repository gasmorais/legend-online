package cell.mediator.fashionbag
{
   import cell.view.fashionbag.FashionBagCell;
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FashionBagCellClickMediator implements IMediator
   {
      
      private var _cell:FashionBagCell;
      
      public function FashionBagCellClickMediator()
      {
         super();
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as FashionBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         if(fashionModel.scene == "SHOP_SCENE")
         {
            if(_cell.moveType == "TRY_ON" && fashionModel.isFashion(_cell.data))
            {
               fashionModel.wearFahion(_cell.data);
            }
            if(_cell.moveType == "GET_OFF")
            {
               fashionModel.getOffFashion(_cell.data);
            }
         }
         else if(fashionModel.scene == "FASHION_STORE_SCENE")
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
         }
      }
      
      protected function __mouseDoubleClick(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         if(fashionModel.scene == "SHOP_SCENE")
         {
            if(_cell.moveType == "TRY_ON" && fashionModel.isFashion(_cell.data))
            {
               fashionModel.wearFahion(_cell.data);
            }
            if(_cell.moveType == "GET_OFF")
            {
               fashionModel.getOffFashion(_cell.data);
            }
         }
         else if(fashionModel.scene == "FASHION_STORE_SCENE")
         {
            if(fashionModel.opState == 1)
            {
               return;
            }
            if(fashionModel.opState == 2)
            {
               fashionModel.resetMovieclip();
            }
            if(fashionModel.selectedPanel == "FASHION_COMPOSE_PANEL")
            {
               if(_cell.data.bagType == 1)
               {
                  if(fashionModel.lookDragonTalkerFashion && _cell.data.templateInfo && _cell.data.templateInfo.Job != "99" && _cell.data.templateInfo.SonType != 278)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips2"));
                     return;
                  }
                  if(!fashionModel.lookDragonTalkerFashion && _cell.data.templateInfo && _cell.data.templateInfo.Job == "99")
                  {
                     if(!DragonTalkerManager.instance.model.isOpen)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips3"));
                        return;
                     }
                     if(!VersionSwitch.DRAGONIC_FASHION)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips4"));
                        return;
                     }
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips1"));
                     return;
                  }
                  if(canMoveToHideBag(_cell.data,true))
                  {
                     PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,fashionModel.to_pos,1);
                  }
               }
               else if(_cell.data.bagType == 0)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,1,0,0,1);
               }
            }
            if(fashionModel.selectedPanel == "FASHION_SWITCH_PANEL")
            {
               if(_cell.data.bagType == 1 || _cell.data.bagType == 4)
               {
                  if(canMoveToHideBag(_cell.data,false))
                  {
                     PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,fashionModel.to_pos,1);
                  }
               }
               else if(_cell.data.bagType == 0)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,1,0,0,1);
               }
            }
         }
      }
      
      private function canMoveToHideBag(param1:GoodsInfo, param2:Boolean) : Boolean
      {
         var _loc5_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc3_:Array = GoodsManager.instance.getGoodsByBagType(0);
         if(_loc3_ == null || _loc3_.length <= 0)
         {
            return true;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if((_loc3_[_loc4_] as GoodsInfo).pos != fashionModel.to_pos)
            {
               _loc5_ = _loc3_[_loc4_] as GoodsInfo;
            }
            _loc4_++;
         }
         if(_loc5_ == null)
         {
            return true;
         }
         if(param1.templateId == 208020 && param2)
         {
            if((_loc5_ as GoodsInfo).templateId == 208020)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("fashion.view.compose.oneEquipLess"));
               return false;
            }
            return true;
         }
         if((_loc5_ as GoodsInfo).templateInfo.SonType != param1.templateInfo.SonType && (_loc5_ as GoodsInfo).templateId != 208020)
         {
            if(fashionModel.selectedPanel == "FASHION_COMPOSE_PANEL")
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("fashion.FashionComposeView.sontypeCannotCompose"));
               return false;
            }
            if(fashionModel.selectedPanel == "FASHION_SWITCH_PANEL")
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("fashion.FashionSwitchView.sontypeCannotSwitch"));
               return false;
            }
         }
         return true;
      }
      
      private function getFashionLevelByInfo(param1:GoodsInfo) : int
      {
         if(!param1)
         {
            return 0;
         }
         if(param1.templateId == 208020)
         {
            return 1;
         }
         if(param1.templateId == 208021)
         {
            return 1;
         }
         var _loc2_:int = param1.randomSkill1;
         if(!TempleteManager.instance.getSkillTemplateInfoById(param1.randomSkill1))
         {
            _loc2_ = int(param1.templateInfo.DefaultSkill.split(",")[0]);
         }
         return TempleteManager.instance.getSkillTemplateInfoById(_loc2_).Grades;
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell = null;
         }
      }
   }
}

