package theseus.war.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusInsfBagCell;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusInsfBagCellClickMediator implements IMediator
   {
      
      protected var _cell:TheseusInsfBagCell;
      
      public function TheseusInsfBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as TheseusInsfBagCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            _cell.icon.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell = null;
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell.data)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,1]);
      }
      
      protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RoyaltyTempInfo = null;
         var _loc2_:int = 0;
         var _loc5_:TheseusWarsoulItemInfo = null;
         if(!_cell.data)
         {
            return;
         }
         if(_cell.funType == 0)
         {
            _loc3_ = int(RoyaltyBossManager.instance.model.royaltyLevel);
            _loc4_ = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc3_);
            if(_loc4_.OpenWarSoul >= _cell.data.warTempInfo.SonType)
            {
               TheseussoulManager.Instance.doWarsoulParam(10,-1,_cell.data.id,0);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.noDoEquip"));
            }
         }
         else if(_cell.funType == 1)
         {
            _loc2_ = int(TheseussoulManager.Instance.warsoulModel.instensifyFunType);
            if(_loc2_ == 6)
            {
               if(_cell.data.isEquip)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.inEquipSolve"));
                  return;
               }
               if(_cell.data.isLock)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.inEquipSolvelock"));
                  return;
               }
               if(TheseussoulManager.Instance.warsoulModel.fenjieMax >= 12)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.fengjiecaoMax"));
                  return;
               }
            }
            _loc5_ = TheseussoulManager.Instance.warsoulModel.currInsSelectInfo;
            if(_loc5_)
            {
               _loc5_.objectId = 0;
            }
            _cell.data.objectId = 1;
            NotificationManager.instance.sendNotification("Event.theseusInsPutIn",_cell.data.id);
         }
      }
   }
}

