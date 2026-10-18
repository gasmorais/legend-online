package avenger.item
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
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.interfaces.IDragTarget;
   import yishi.manager.AvengerManager;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerDevilArmorItemCell extends BaseItemView
   {
      
      public var showType:int;
      
      public var canClick:Boolean;
      
      public function AvengerDevilArmorItemCell(param1:int, param2:Boolean = true)
      {
         super();
         showType = param1;
         canClick = param2;
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
         if(!canClick)
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
            _loc2_.dropChecks = [AvengerDevilArmorItemCell,IDragTarget,Stage];
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
         var _loc3_:AvengerDevilArmorItemCell = null;
         this.setNormalFilter();
         var _loc2_:int = -1;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is AvengerDevilArmorItemCell)
            {
               _loc3_ = param1.dropTarget as AvengerDevilArmorItemCell;
               if(_loc3_.showType == this.showType)
               {
                  param1.stopImmediatePropagation();
                  return;
               }
               if(_loc3_.data)
               {
                  if(this.showType == 1)
                  {
                     _loc2_ = int(model.checkCanExchangePos(this.data,pos,_loc3_.data,_loc3_.pos));
                     dealBagHandler(_loc2_,this.data.templateId);
                  }
                  else
                  {
                     if(_loc3_.data.templateInfo.SonType != 670)
                     {
                        return;
                     }
                     _loc2_ = int(model.checkCanExchangePos(_loc3_.data,_loc3_.pos,this.data,pos));
                     dealBagHandler(_loc2_,_loc3_.data.templateId);
                  }
               }
               else if(this.showType == 1)
               {
                  _loc2_ = int(model.checkEquipByPos(_loc3_.pos,this.data));
                  dealBagHandler(_loc2_,this.data.templateId);
               }
               else
               {
                  AvengerManager.instance.sendDevilArmorEquip(pos);
               }
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function dealBagHandler(param1:int, param2:int) : void
      {
         if(param1 >= 0)
         {
            AvengerManager.instance.sendDevilArmorEquip(param1,param2);
         }
         else
         {
            alertMessage(param1);
         }
      }
      
      private function __doubleClickHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(!this.data)
         {
            return;
         }
         if(!canClick)
         {
            return;
         }
         if(showType == 1)
         {
            _loc2_ = int(model.checkCanEquipPos(this.data));
            dealBagHandler(_loc2_,this.data.templateId);
         }
         else if(showType == 2)
         {
            AvengerManager.instance.sendDevilArmorEquip(pos);
         }
         param1.stopImmediatePropagation();
      }
      
      private function alertMessage(param1:int) : void
      {
         if(param1 == -1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerDevilArmorView.holeEquip.alert1"));
         }
         else if(param1 == -2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerDevilArmorView.holeEquip.alert2"));
         }
         else if(param1 == -3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerDevilArmorView.holeEquip.alert3"));
         }
         else if(param1 == -4)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerDevilArmorView.holeEquip.alert4"));
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(data)
         {
            if(data.templateInfo.SonType == 670)
            {
               addEvent();
            }
            if(_itemText)
            {
               if(showType == 2 && param1.count <= 1)
               {
                  _itemText.text = "";
               }
               else
               {
                  _itemText.text = getCountStr(param1);
               }
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
         super.dispose();
      }
   }
}

