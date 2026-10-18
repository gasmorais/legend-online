package yishi.view.tips.rune
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class RuneXingItem extends BaseItemView
   {
      
      public static const P_suitStyle:String = "suitStyle";
      
      private var _xing:int;
      
      private var _suitStyle:String;
      
      private var _suitBit:ScaleFrameImage;
      
      private var _isSuit:Boolean;
      
      private var _lockBit:ScaleFrameImage;
      
      public function RuneXingItem()
      {
         super();
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(param1)
         {
            if(_itemText)
            {
               _itemText.text = LanguageMgr.GetTranslation("public.level2",param1.strengthenGrade);
            }
         }
      }
      
      override public function hideVpLock() : void
      {
         if(_lockBit)
         {
            _lockBit.visible = false;
         }
      }
      
      override public function showVpLock() : void
      {
         if(_lockBit == null)
         {
            _lockBit = ComponentFactory.Instance.creatComponentByStylename("ui.army.stone.bagCellLock2");
            addChild(_lockBit);
         }
         _lockBit.visible = true;
      }
      
      public function set xing(param1:int) : void
      {
         if(_xing == param1)
         {
            return;
         }
         _xing = param1;
         var _loc2_:Bitmap = _back as Bitmap;
         if(_loc2_)
         {
            _loc2_.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.army.stone.shape" + _xing);
         }
         else
         {
            backgroundStyle = "asset.army.stone.shape" + _xing;
         }
      }
      
      public function set suitStyle(param1:String) : void
      {
         if(_suitStyle == param1)
         {
            return;
         }
         _suitStyle = param1;
         onPropertiesChanged("suitStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["suitStyle"])
         {
            _suitBit = ComponentFactory.Instance.creatComponentByStylename(_suitStyle);
            _suitBit.setFrame(2);
            _suitBit.mouseChildren = false;
            _suitBit.mouseEnabled = false;
            isSuit = false;
         }
      }
      
      public function set isSuit(param1:Boolean) : void
      {
         _isSuit = param1;
         if(_suitBit)
         {
            _suitBit.visible = _isSuit;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_suitBit)
         {
            addChild(_suitBit);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

