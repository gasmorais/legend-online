package dragontalker.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import dragontalker.cell.DragonTalkerTalismanBagCell;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.interfaces.IMediator;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerBagCellClickMediator implements IMediator
   {
      
      private var _cell:DragonTalkerTalismanBagCell;
      
      public function DragonTalkerBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as DragonTalkerTalismanBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
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
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         if(model.isOpenMutiIntensify)
         {
            return;
         }
         MsgMan.notifyObserver("DRAG_ITEM_BagNotic",{
            "cell":_cell,
            "data":_cell.data
         });
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         var _loc2_:DragonTalkerTalismanInfo = null;
         var _loc3_:DragonTalkerTalismanInfo = null;
         if(!canDoubleClick)
         {
            return;
         }
         if(model.isOpenMutiIntensify)
         {
            return;
         }
         if(model.bagViewType == 1)
         {
            if(_cell.data.isExpType)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTalkerBagCell.equipNoType.expAlert"));
               return;
            }
            DragonTalkerManager.instance.sendDragonTalkerTalismanReq(3,_cell.data.id);
         }
         else if(model.bagViewType == 2)
         {
            if(model.hideCellDic["2_1"])
            {
               model.hideCellDic.add("2_2",_cell.data);
            }
            else if(_cell.data.isExpType)
            {
               model.hideCellDic.add("2_2",_cell.data);
            }
            else
            {
               model.hideCellDic.add("2_1",_cell.data);
            }
            MsgMan.notifyObserver("HIDE_DIC_CHANGE");
         }
         else if(model.bagViewType == 3)
         {
            if(_cell.data.isExpType)
            {
               return;
            }
            if(model.hideCellDic["3_1"])
            {
               _loc2_ = model.hideCellDic["3_1"];
               if(_loc2_.goodsTempInfo.SonType == _cell.data.goodsTempInfo.SonType)
               {
                  model.hideCellDic.add("3_2",_cell.data);
               }
               else
               {
                  model.hideCellDic.clear();
                  model.hideCellDic.add("3_1",_cell.data);
               }
               MsgMan.notifyObserver("HIDE_DIC_CHANGE");
            }
            else
            {
               model.hideCellDic.add("3_1",_cell.data);
               if(model.hideCellDic["3_2"])
               {
                  _loc3_ = model.hideCellDic["3_2"];
                  if(_loc3_.goodsTempInfo.SonType != _cell.data.goodsTempInfo.SonType)
                  {
                     model.hideCellDic.del("3_2");
                  }
               }
               MsgMan.notifyObserver("HIDE_DIC_CHANGE");
            }
         }
         MsgMan.notifyObserver("SWITCH_EQUIPVIEW");
      }
      
      private function get canDoubleClick() : Boolean
      {
         if(!_cell.data)
         {
            return false;
         }
         return true;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
   }
}

