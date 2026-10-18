package store.resolve
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.interfaces.IDragTarget;
   import yishi.manager.AvengerManager;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerStoreItemCell extends BaseItemView
   {
      
      public var showType:int;
      
      public var isCheck:Boolean = false;
      
      private var _chooseImg:Bitmap;
      
      private var _isChoose:Boolean = false;
      
      public function AvengerStoreItemCell(param1:int)
      {
         super();
         showType = param1;
         _chooseImg = ComponentFactory.Instance.creatBitmap("asset.store.avengerPopupGou");
      }
      
      private function addEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(this);
         this.addEventListener("interactive_click",__clickHandler);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         MsgMan.addObserver("AVENGER_ALL_RESOLVE",this,_updateItem);
         MsgMan.addObserver("DEVIL_ARMOR_BAG_UPDATE",this,_updateItem);
      }
      
      private function removeEvent() : void
      {
         if(this)
         {
            MsgMan.removeObserver("AVENGER_ALL_RESOLVE",this,_updateItem);
            this.removeEventListener("interactive_click",__clickHandler);
            this.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(this);
            MsgMan.removeObserver("DEVIL_ARMOR_BAG_UPDATE",this,_updateItem);
         }
      }
      
      private function __clickHandler(param1:Event) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:GameDrag = null;
         if(_isChoose)
         {
            return;
         }
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
            _loc2_.dropChecks = [AvengerStoreItemCell,IDragTarget,Stage];
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
         var _loc3_:AvengerStoreItemCell = null;
         if(_isChoose)
         {
            return;
         }
         this.setNormalFilter();
         var _loc2_:int = -1;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is AvengerStoreItemCell)
            {
               _loc3_ = param1.dropTarget as AvengerStoreItemCell;
               if(_loc3_.showType == this.showType || _loc3_.showType == 2)
               {
                  param1.stopImmediatePropagation();
                  return;
               }
               if(_loc3_.data)
               {
                  if(this.showType == 1)
                  {
                     model.moveBagToResolve(this.data);
                     model.moveResolveToBag(_loc3_.data);
                     MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
                  }
                  else if(this.showType == 3)
                  {
                     model.moveBagToResolve(_loc3_.data);
                     model.moveResolveToBag(this.data);
                     MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
                  }
               }
               else if(this.showType == 1)
               {
                  model.moveBagToResolve(this.data);
                  MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
               }
               else if(this.showType == 3)
               {
                  model.moveResolveToBag(this.data);
                  MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
               }
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function __doubleClickHandler(param1:Event) : void
      {
         if(_isChoose)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Title.tips"));
            return;
         }
         if(!this.data)
         {
            return;
         }
         if(showType == 1)
         {
            if(model.resolveBagDic.keys.length >= 4)
            {
               return;
            }
            model.moveBagToResolve(this.data);
            MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
         }
         else if(showType == 3)
         {
            model.moveResolveToBag(this.data);
            MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
         }
         param1.stopImmediatePropagation();
      }
      
      private function _updateItem(param1:String, param2:Array = null) : void
      {
         if(_chooseImg)
         {
            _chooseImg.visible = false;
         }
         if(!this.data)
         {
            return;
         }
         if(param1 != "AVENGER_ALL_RESOLVE")
         {
            return;
         }
         if(showType == 1)
         {
            if(param2 && (param2[0] != 0 || param2[1] != 0))
            {
               if(param2[1] == 0)
               {
                  if(this.data.descTemplateInfo.Property1 <= param2[0])
                  {
                     model.allResolve(this.data);
                     MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
                     if(_chooseImg)
                     {
                        addChild(_chooseImg);
                     }
                     _chooseImg.scaleX = _chooseImg.scaleY = 0.4;
                     _chooseImg.visible = true;
                     _isChoose = true;
                  }
               }
               else if(this.data.descTemplateInfo.Profile == param2[1] && this.data.descTemplateInfo.Property1 <= param2[0])
               {
                  model.allResolve(this.data);
                  MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
                  if(_chooseImg)
                  {
                     addChild(_chooseImg);
                  }
                  _chooseImg.scaleX = _chooseImg.scaleY = 0.4;
                  _chooseImg.visible = true;
                  _isChoose = true;
               }
            }
            else
            {
               model.allResolveToBag(this.data);
               MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
               _chooseImg.visible = false;
               _isChoose = false;
            }
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(data)
         {
            if(showType != 2)
            {
               addEvent();
            }
            if(_itemText)
            {
               _itemText.text = getCountStr(param1);
            }
         }
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_chooseImg);
         _chooseImg = null;
         super.dispose();
      }
   }
}

