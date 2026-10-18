package theseus.war.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import theseus.war.item.TheseusFJItem;
   import theseus.war.item.TheseusInsfBagCell;
   import theseus.war.item.TheseusWarEquipCell;
   import theseus.war.item.TheseusWarIntensifyCell;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusInsfBagCellDropMediator implements IMediator
   {
      
      protected var _cell:TheseusInsfBagCell;
      
      public function TheseusInsfBagCellDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as TheseusInsfBagCell;
         NotificationManager.instance.addEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         NotificationManager.instance.addEventListener("ITEM_DROP_BagNotic",__itemDropBagHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         NotificationManager.instance.removeEventListener("ITEM_DROP_BagNotic",__itemDropBagHandler);
         _cell = null;
      }
      
      protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[0] == _cell && !DragManager.getInstance().isDraging)
         {
            starItemDrag(param1.data[1] || -1);
         }
      }
      
      protected function __itemDropBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[1])
         {
            if(param1.data[0] && param1.data[0] == _cell && _cell.icon)
            {
               _cell.setNormalFilter();
            }
         }
         else if(_cell.icon)
         {
            _cell.setNormalFilter();
         }
      }
      
      protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [TheseusWarEquipCell,TheseusWarIntensifyCell,TheseusFJItem,Stage];
         _cell.setGrayFilter();
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc3_:TheseusWarEquipCell = null;
         var _loc2_:TheseusWarIntensifyCell = null;
         _cell.isDraging = false;
         _cell.setNormalFilter();
         if(param1.dropTarget is TheseusWarEquipCell)
         {
            _loc3_ = param1.dropTarget as TheseusWarEquipCell;
            if(_loc3_ && !_loc3_.isLock)
            {
               if(_cell.data.warTempInfo.SonType == _loc3_.sonType)
               {
                  TheseussoulManager.Instance.doWarsoulParam(10,-1,_cell.data.id,0);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.doEquip"));
               }
            }
         }
         else if(param1.dropTarget is TheseusWarIntensifyCell)
         {
            _loc2_ = param1.dropTarget as TheseusWarIntensifyCell;
            if(_loc2_)
            {
               if(_loc2_.funType != 0)
               {
                  if(_loc2_.data)
                  {
                     _loc2_.data.objectId = 0;
                  }
                  _cell.data.objectId = 1;
                  NotificationManager.instance.sendNotification("Event.theseusInsPutIn",_cell.data.id);
               }
            }
         }
         else if(param1.dropTarget is TheseusFJItem)
         {
            if(_cell.data.isEquip)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.inEquipSolve"));
            }
            else if(_cell.data.isLock)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.inEquipSolvelock"));
            }
            else if(TheseussoulManager.Instance.warsoulModel.fenjieMax < 12)
            {
               _cell.data.objectId = 1;
               NotificationManager.instance.sendNotification("Event.theseusInsPutIn",_cell.data.id);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.fengjiecaoMax"));
            }
         }
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc3_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc4_:Bitmap = null;
         var _loc5_:DisplayObject = _cell.icon.content;
         if(_cell.data && _loc5_)
         {
            _loc3_ = new Sprite();
            _loc1_ = _loc5_.getRect(_loc5_);
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc6_ = new Matrix();
            _loc6_.translate(-_loc1_.x,-_loc1_.y);
            _loc2_.draw(_loc5_,_loc6_);
            _loc4_ = new Bitmap(_loc2_);
            _loc4_.alpha = 1;
            _loc4_.width = _loc2_.width;
            _loc4_.height = _loc2_.height;
            _loc3_.addChild(_loc4_);
            return _loc3_;
         }
         return null;
      }
   }
}

