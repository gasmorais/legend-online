package monster.mediator
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
   import monster.cell.MonsterAccessoriesBagCell;
   import monster.cell.MonsterAccessoriesEquipCell;
   import monster.cell.MonsterAccessoriesItemCell;
   import mvc.module.monster.MonsterModel;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.manager.MonsterManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterAccessoriesBagCellDropMediator implements IMediator
   {
      
      private var _cell:MonsterAccessoriesBagCell;
      
      public function MonsterAccessoriesBagCellDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as MonsterAccessoriesBagCell;
         NotificationManager.instance.addEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         _cell = null;
      }
      
      protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[0] == _cell && !DragManager.getInstance().isDraging)
         {
            starItemDrag(param1.data[1] || -1);
         }
      }
      
      protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{"icon":_loc3_});
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [MonsterAccessoriesEquipCell,MonsterAccessoriesItemCell,Stage];
         _cell.setGrayFilter();
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc4_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc7_:Matrix = null;
         var _loc5_:Bitmap = null;
         var _loc3_:GoodsInfo = _cell.data;
         var _loc6_:DisplayObject = _cell.icon;
         if(_loc3_ && _loc6_)
         {
            _loc4_ = new Sprite();
            _loc1_ = _loc6_.getRect(_loc6_);
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc7_ = new Matrix();
            _loc7_.translate(-_loc1_.x,-_loc1_.y);
            _loc2_.draw(_loc6_,_loc7_);
            _loc5_ = new Bitmap(_loc2_);
            _loc5_.alpha = 1;
            _loc5_.width = _loc2_.width;
            _loc5_.height = _loc2_.height;
            _loc4_.addChild(_loc5_);
            return _loc4_;
         }
         return null;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc2_:String = null;
         var _loc3_:MonsterAccessoriesItemCell = null;
         if(!_cell || !_cell.data || !_cell.data.templateInfo)
         {
            return;
         }
         _cell.setNormalFilter();
         if(param1.dropTarget is MonsterAccessoriesEquipCell)
         {
            if(_cell.data.templateInfo.SonType == 232)
            {
               PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,0,1);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.command02");
               MessageTipManager.instance().show(_loc2_);
            }
         }
         else if(param1.dropTarget is MonsterAccessoriesItemCell)
         {
            if(_cell.data.bagType == 37)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterAccessoriesBagCellDropMediator.error.text"));
            }
            else
            {
               _loc3_ = param1.dropTarget as MonsterAccessoriesItemCell;
               if(_loc3_)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,_loc3_.pos,param1.data);
               }
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
   }
}

