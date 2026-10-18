package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.stele.StelesysInfo;
   
   public class StelesysBoxItem extends StelesysBaseBoxItem
   {
      
      protected var _lvBg:Bitmap;
      
      protected var _lvTxt:FilterFrameText;
      
      protected var _starBox:HBox;
      
      protected var _star:int;
      
      protected var _colorImg:ScaleFrameImage;
      
      public function StelesysBoxItem()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _lvBg = ComponentFactory.Instance.creatBitmap("asset.stelesys.lvBg");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.boxLvTxt");
         _starBox = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.starBox");
         _colorImg = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.smallColorImg");
         _scaleSp.addChild(_lvBg);
         _scaleSp.addChild(_lvTxt);
         _scaleSp.addChild(_starBox);
         _scaleSp.addChild(_colorImg);
         _colorImg.visible = false;
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1 == null)
         {
            _boxBg.setFrame(1);
            _icon.icon = null;
            _colorImg.visible = false;
            _lvBg.visible = false;
            _lvTxt.visible = false;
            star = 0;
            return;
         }
         if(param1.stepColor <= 1)
         {
            _colorImg.visible = false;
         }
         else
         {
            _colorImg.visible = true;
            _colorImg.setFrame(param1.stepColor - 1);
         }
         _lvBg.visible = true;
         _lvTxt.visible = true;
         star = _data.tempInfo.Rarity;
         _lvTxt.text = "" + _data.level;
         var _loc2_:int = 1;
         if(_data.isOnEquip)
         {
            _loc2_ = 2;
         }
         _boxBg.setFrame(_loc2_);
      }
      
      protected function set star(param1:int) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:int = 0;
         if(_star == param1)
         {
            return;
         }
         _star = param1;
         _starBox.disposeAllChildren();
         _starBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.stelesys.star");
            _starBox.addChild(_loc2_);
            _loc3_++;
         }
         _starBox.commitChanges();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_lvBg);
         _lvBg = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_starBox);
         _starBox = null;
         ObjectUtils.disposeObject(_colorImg);
         _colorImg = null;
         super.dispose();
      }
   }
}

