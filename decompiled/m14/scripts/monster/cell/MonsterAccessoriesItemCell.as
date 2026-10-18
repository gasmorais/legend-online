package monster.cell
{
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.DragManager;
   import yishi.manager.MonsterManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   
   public class MonsterAccessoriesItemCell extends BaseItemView
   {
      
      public function MonsterAccessoriesItemCell(param1:int)
      {
         super();
         pos = param1;
      }
      
      private function addEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(this);
         this.addEventListener("interactive_click",__clickHandler);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(this)
         {
            this.removeEventListener("interactive_click",__clickHandler);
            this.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(this);
         }
      }
      
      private function __clickHandler(param1:Event) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:GameDrag = null;
         if(data && !DragManager.getInstance().isDraging)
         {
            SoundManager.instance.play("028",true);
            _loc3_ = getDragIconObj();
            if(!_loc3_)
            {
               return;
            }
            _loc2_ = DragManager.getInstance().starDrag(this,{
               "icon":_loc3_,
               "type":"down"
            });
            _loc2_.data = data;
            _loc2_.onDrop = beDropHitCallBack;
            _loc2_.dropChecks = [MonsterAccessoriesBagCell,Stage];
            this.setGrayFilter();
         }
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc3_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc4_:Bitmap = null;
         var _loc5_:DisplayObject = this.icon.content;
         if(data && _loc5_)
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
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         this.setNormalFilter();
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is MonsterAccessoriesBagCell)
            {
               PlayerManager.instance.moveBagToBag(data.bagType,data.objectId,data.pos,1,0,0,1);
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function __doubleClickHandler(param1:Event) : void
      {
         if(!this.data)
         {
            return;
         }
         PlayerManager.instance.moveBagToBag(data.bagType,data.objectId,data.pos,1,0,0,1);
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(data)
         {
            addEvent();
            if(_itemText)
            {
               _itemText.text = "";
            }
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

