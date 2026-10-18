package theseusgodhead.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.TransformableComponent;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseus.TheseusGodheadStoneInfo;
   import mvc.module.theseus.TheseusSlateAssetHelper;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   
   public class GodheadUpStarCell extends Sprite
   {
      
      public static const FUNTPYE_QH:int = 1;
      
      public static const FUNTPYE_GZ:int = 2;
      
      private var _tipComponent:TransformableComponent;
      
      public var _warEquipIntensifyCellBg:Bitmap;
      
      public var _warEquipIntensifyCellBg1:Bitmap;
      
      public var _intensifyEquipCTxt:FilterFrameText;
      
      private var _data:TheseusGodheadStoneInfo;
      
      private var _funType:int;
      
      public var isNormalFilter:Boolean = true;
      
      public var isDraging:Boolean = false;
      
      protected var _filter:IFilterFormat;
      
      private var _isRigist:Boolean;
      
      protected var _mediatorKey:String;
      
      public const NAME:String = "theseusgodhead.item.GodheadUpStarCell";
      
      private var _profile:ScaleFrameImage;
      
      private var _stoneIcon:Bitmap;
      
      public function GodheadUpStarCell()
      {
         super();
         initView();
      }
      
      public function get funType() : int
      {
         return _funType;
      }
      
      public function set funType(param1:int) : void
      {
         _funType = param1;
      }
      
      public function get data() : TheseusGodheadStoneInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusGodheadStoneInfo) : void
      {
         _data = param1;
         if(_data)
         {
            mouseEnabled = true;
            mouseChildren = true;
            if(_tipComponent)
            {
               _tipComponent.tipData = param1;
            }
            updateStoneIcon();
            _intensifyEquipCTxt.visible = false;
         }
         else
         {
            _intensifyEquipCTxt.visible = true;
            clearStoneIcon();
         }
      }
      
      private function updateStoneIcon() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         clearStoneIcon();
         if(_data && _data.shape > 0)
         {
            _stoneIcon = TheseusSlateAssetHelper.getSlateDisplay(_data.shape,_data.rotate);
            if(_stoneIcon)
            {
               _loc2_ = _stoneIcon.width;
               _loc1_ = _stoneIcon.height;
               _stoneIcon.scaleX = 0.3;
               _stoneIcon.scaleY = 0.3;
               _stoneIcon.x = 40 - _loc2_ * 0.3 / 2;
               _stoneIcon.y = 40 - _loc1_ * 0.3 / 2;
               addChildAt(_stoneIcon,2);
            }
         }
      }
      
      private function clearStoneIcon() : void
      {
         if(_stoneIcon)
         {
            if(_stoneIcon.parent)
            {
               _stoneIcon.parent.removeChild(_stoneIcon);
            }
            _stoneIcon = null;
         }
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _warEquipIntensifyCellBg = ComponentFactory.Instance.creatBitmap("TheseusGodHeadskillol");
         _warEquipIntensifyCellBg1 = ComponentFactory.Instance.creatBitmap("TheseusGodHeadskillbg");
         _intensifyEquipCTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.intensifyEquipCTxt");
         _profile = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.warCell.Profile2");
         addChild(_warEquipIntensifyCellBg1);
         addChild(_warEquipIntensifyCellBg);
         addChild(_intensifyEquipCTxt);
         addChild(_profile);
         _profile.visible = false;
         _intensifyEquipCTxt.x = 12;
         _intensifyEquipCTxt.y = 32;
         _intensifyEquipCTxt.text = LanguageMgr.GetTranslation("theseusgodhead.txt11");
         _tipComponent = new TransformableComponent();
         _tipComponent.x = 0;
         _tipComponent.y = 0;
         _tipComponent.tipStyle = "yishi.view.tips.TheseusGodheadEquipTip";
         _tipComponent.graphics.beginFill(0,0);
         _tipComponent.graphics.drawRect(0,0,this.width,this.height);
         _tipComponent.graphics.endFill();
         _tipComponent.mouseEnabled = true;
         addChild(_tipComponent);
      }
      
      public function set defaultStr(param1:String) : void
      {
         _intensifyEquipCTxt.text = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_warEquipIntensifyCellBg);
         _warEquipIntensifyCellBg = null;
         ObjectUtils.disposeObject(_intensifyEquipCTxt);
         _intensifyEquipCTxt = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         clearStoneIcon();
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _filter = null;
      }
   }
}

