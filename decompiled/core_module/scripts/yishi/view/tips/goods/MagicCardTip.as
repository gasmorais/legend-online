package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class MagicCardTip extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _title:FilterFrameText;
      
      private var _bindText:FilterFrameText;
      
      private var _propertyTxt:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _grade:FilterFrameText;
      
      private var _send:FilterFrameText;
      
      private var _container:Sprite;
      
      private var _yellowBg:Scale9CornerImage;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _blueBg:Scale9CornerImage;
      
      private var _greenBg:Scale9CornerImage;
      
      private var _whiteBg:Scale9CornerImage;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      public function MagicCardTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _container = new Sprite();
         _bg.width = 360;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         _bindText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodBindText1");
         _propertyTxt = ComponentFactory.Instance.creatComponentByStylename("tips.CardPropertyText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText");
         _price = ComponentFactory.Instance.creatComponentByStylename("tips.GoodPriceText");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsTotalBox");
         _grade = ComponentFactory.Instance.creatComponentByStylename("tips.GoodGradeText");
         _send = ComponentFactory.Instance.creatComponentByStylename("tips.GoodsSendTxt");
         _yellowBg = ComponentFactory.Instance.creatComponentByStylename("core.yellowItemTipsBg");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _blueBg = ComponentFactory.Instance.creatComponentByStylename("core.blueItemTipsBg");
         _greenBg = ComponentFactory.Instance.creatComponentByStylename("core.greenItemTipsBg");
         _whiteBg = ComponentFactory.Instance.creatComponentByStylename("core.whiteItemTipsBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine01.width = 335;
         _splitLine02.width = 335;
         addChild(_yellowBg);
         addChild(_purpleBg);
         addChild(_blueBg);
         addChild(_greenBg);
         addChild(_whiteBg);
         addChild(_itemIcon);
         _itemIcon.x = 9;
         addChild(_profileImg);
         _profileImg.x = 8;
         _describe.width = 337;
         addChild(_title);
         _title.width = 270;
         _title.x = 71;
         _title.y = 15;
         _totalBox.x = 10;
         _totalBox.y = 58;
         _totalBox.spacing = 4;
         _grade.x = 130;
         addChild(_totalBox);
         _price.x = 0;
         _bindText.x = 0;
      }
      
      override protected function updateTransform() : void
      {
      }
      
      private function showProfileBg(param1:int) : void
      {
         _bg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
         }
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         while(_totalBox.numChildren > 0)
         {
            _loc1_ = _totalBox.getChildAt(0);
            _totalBox.removeChild(_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_container);
         if(_yellowBg)
         {
            ObjectUtils.disposeObject(_yellowBg);
         }
         _yellowBg = null;
         if(_purpleBg)
         {
            ObjectUtils.disposeObject(_purpleBg);
         }
         _purpleBg = null;
         if(_blueBg)
         {
            ObjectUtils.disposeObject(_blueBg);
         }
         _blueBg = null;
         if(_greenBg)
         {
            ObjectUtils.disposeObject(_greenBg);
         }
         _greenBg = null;
         if(_whiteBg)
         {
            ObjectUtils.disposeObject(_whiteBg);
         }
         _whiteBg = null;
         if(_itemIcon)
         {
            ObjectUtils.disposeObject(_itemIcon);
         }
         _itemIcon = null;
         if(_profileImg)
         {
            ObjectUtils.disposeObject(_profileImg);
         }
         _profileImg = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_bindText)
         {
            _bindText.dispose();
         }
         _bindText = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_price)
         {
            _price.dispose();
         }
         _price = null;
         if(_grade)
         {
            _grade.dispose();
         }
         _grade = null;
         if(_send)
         {
            _send.dispose();
         }
         _send = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

