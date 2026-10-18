package store.resolve
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
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
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.interfaces.IDragTarget;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseWarItem;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusStoreItemCell extends BaseWarItem
   {
      
      public static const P_FullStyle:String = "fullStyle";
      
      public static const P_FullStyleY:String = "fullStyleY";
      
      public static const P_FullStyleX:String = "fullStyleX";
      
      public var showType:int;
      
      private var _chooseImg:Bitmap;
      
      private var _strengNumSprite:Sprite;
      
      private var _strengImg:BitmapData;
      
      private var _fullStyleY:int;
      
      private var _fullStyleX:int;
      
      private var _lvTxt:FilterFrameText;
      
      private var _fullStyle:String;
      
      private var _fullBit:Bitmap;
      
      private var _isChoose:Boolean = false;
      
      public function TheseusStoreItemCell(param1:int)
      {
         super();
         showType = param1;
         _chooseImg = ComponentFactory.Instance.creatBitmap("asset.store.avengerPopupGou");
         _chooseImg.visible = false;
      }
      
      public function set fullStyle(param1:String) : void
      {
         _fullStyle = param1;
         onPropertiesChanged("fullStyle");
      }
      
      public function set fullStyleY(param1:int) : void
      {
         _fullStyleY = param1;
         onPropertiesChanged("fullStyleY");
      }
      
      public function set fullStyleX(param1:int) : void
      {
         _fullStyleX = param1;
         onPropertiesChanged("fullStyleX");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["fullStyle"])
         {
            _fullBit = ComponentFactory.Instance.creatBitmap(_fullStyle);
            _strengImg = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
            if(_changedPropeties["fullStyleY"])
            {
               _fullBit.y = _fullStyleY;
            }
            if(_changedPropeties["fullStyleX"])
            {
               _fullBit.x = _fullStyleX;
            }
            _fullBit.scaleX = _fullBit.scaleY = 0.9;
            _fullBit.x = 2;
            _fullBit.y = 1;
            _strengNumSprite = new Sprite();
            _strengNumSprite.y = 5;
            _strengNumSprite.x = 12;
            _strengNumSprite.scaleX = _strengNumSprite.scaleY = 0.7;
            _fullBit.visible = false;
            _strengNumSprite.mouseChildren = _strengNumSprite.mouseEnabled = false;
         }
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseusbagCell.lvText");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_fullBit)
         {
            addChild(_fullBit);
            addChild(_strengNumSprite);
         }
         if(_lvTxt)
         {
            addChild(_lvTxt);
         }
      }
      
      private function addEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(this);
         this.addEventListener("interactive_click",__clickHandler);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         MsgMan.addObserver("THESEUS_ALL_RESOLVE",this,_updateItem);
         MsgMan.addObserver("EVENT_THESEUS_BAG_UPDATE",this,_updateItem);
      }
      
      private function setStrengNum(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_strengNumSprite,_strengImg,19,22,10,19,"0123456789");
      }
      
      private function removeEvent() : void
      {
         if(this)
         {
            MsgMan.removeObserver("THESEUS_ALL_RESOLVE",this,_updateItem);
            MsgMan.removeObserver("EVENT_THESEUS_BAG_UPDATE",this,_updateItem);
            this.removeEventListener("interactive_click",__clickHandler);
            this.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(this);
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
            _loc2_.dropChecks = [TheseusStoreItemCell,IDragTarget,Stage];
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
         var _loc3_:TheseusStoreItemCell = null;
         if(_isChoose)
         {
            return;
         }
         this.setNormalFilter();
         var _loc2_:int = -1;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is TheseusStoreItemCell)
            {
               _loc3_ = param1.dropTarget as TheseusStoreItemCell;
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
                     MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
                  }
                  else if(this.showType == 3)
                  {
                     model.moveBagToResolve(_loc3_.data);
                     model.moveResolveToBag(this.data);
                     MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
                  }
               }
               else if(this.showType == 1)
               {
                  model.moveBagToResolve(this.data);
                  MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
               }
               else if(this.showType == 3)
               {
                  model.moveResolveToBag(this.data);
                  MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
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
            MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
         }
         else if(showType == 3)
         {
            model.moveResolveToBag(this.data);
            MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
         }
         param1.stopImmediatePropagation();
      }
      
      private function _updateItem(param1:String, param2:Object = null) : void
      {
         if(_chooseImg)
         {
            _chooseImg.visible = false;
         }
         if(!this.data)
         {
            return;
         }
         if(this.data.isLock)
         {
            return;
         }
         if(param1 != "THESEUS_ALL_RESOLVE")
         {
            return;
         }
         if(showType == 1)
         {
            if(param2 && (param2[0] != 0 || param2[1] != 0))
            {
               if(param2[1] == 0)
               {
                  if(this.data.warTempInfo.Property4 <= param2[0])
                  {
                     model.allResolve(this.data);
                     MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
                     if(_chooseImg)
                     {
                        addChild(_chooseImg);
                     }
                     _chooseImg.scaleX = _chooseImg.scaleY = 0.4;
                     _chooseImg.visible = true;
                     _isChoose = true;
                  }
               }
               else if(this.data.warTempInfo.Property1 == param2[1] && this.data.warTempInfo.Property4 <= param2[0])
               {
                  model.allResolve(this.data);
                  MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
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
               MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
               _chooseImg.visible = false;
               _isChoose = false;
            }
         }
      }
      
      override public function set data(param1:WarFrameItemInfo) : void
      {
         super.data = param1;
         if(_fullBit)
         {
            if(param1)
            {
               _fullBit.visible = param1.strengthen > 0;
               _strengNumSprite.visible = param1.strengthen > 0;
               setStrengNum(param1.strengthen);
            }
            else
            {
               _fullBit.visible = false;
               _strengNumSprite.visible = false;
            }
         }
         if(_lvTxt)
         {
            _lvTxt.text = "";
         }
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
            if(_lvTxt)
            {
               if(param1 && param1.warTempInfo.SonType == 720)
               {
                  _lvTxt.text = LanguageMgr.GetTranslation("public.level2",param1.warTempInfo.Property4);
               }
               else
               {
                  _lvTxt.text = "";
               }
            }
         }
      }
      
      private function get model() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_chooseImg);
         _chooseImg = null;
         ObjectUtils.disposeObject(_fullBit);
         _fullBit = null;
         ObjectUtils.disposeObject(_strengNumSprite);
         _strengNumSprite = null;
         ObjectUtils.disposeObject(_strengImg);
         _strengImg = null;
         super.dispose();
      }
   }
}

