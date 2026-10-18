package mounts
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class MountKingTrainItemView extends Component
   {
      
      private var _type:int = 0;
      
      private var _propertyImg:Image;
      
      private var _preBaseTxt:FilterFrameText;
      
      private var _preAddText:FilterFrameText;
      
      private var _propertyImg2:Image;
      
      private var _nextBaseTxt:FilterFrameText;
      
      private var _nextUpText:FilterFrameText;
      
      private var _nextAddTxt:FilterFrameText;
      
      private var _nextAddUpText:FilterFrameText;
      
      private var _upArrow:Image;
      
      private var _upArrow2:Image;
      
      public function MountKingTrainItemView(param1:int = 1)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:String = null;
         switch(_type - 1)
         {
            case 0:
               _loc1_ = "asset.mounts.StrengthTxt";
               break;
            case 1:
               _loc1_ = "asset.mounts.IntellectTxt";
               break;
            case 2:
               _loc1_ = "asset.mounts.StaminaTxt";
               break;
            case 3:
               _loc1_ = "asset.mounts.ArmorTxt";
               break;
            default:
               _loc1_ = "asset.mounts.ArmorTxt";
         }
         _propertyImg = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.propertyImg");
         _propertyImg2 = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.propertyImg2");
         _propertyImg.resourceLink = _propertyImg2.resourceLink = _loc1_;
         _preBaseTxt = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.preBaseTxt");
         _preAddText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.preAddText");
         _nextBaseTxt = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.nextBaseTxt");
         _nextUpText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.nextUpText");
         _nextAddTxt = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.nextAddTxt");
         _nextAddUpText = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.nextAddUpText");
         _upArrow = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.upArrow");
         _upArrow2 = ComponentFactory.Instance.creatComponentByStylename("MountKingTrainItemView.upArrow2");
         addChild(_propertyImg);
         addChild(_propertyImg2);
         addChild(_preBaseTxt);
         addChild(_preAddText);
         addChild(_nextBaseTxt);
         addChild(_nextUpText);
         addChild(_nextAddTxt);
         addChild(_nextAddUpText);
         addChild(_upArrow);
         addChild(_upArrow2);
      }
      
      public function update(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:Boolean = false) : void
      {
         _preBaseTxt.text = "+" + param1;
         _preAddText.text = "+" + param2;
         _nextBaseTxt.text = "+" + param3;
         _nextUpText.text = param5.toString();
         _upArrow.x = _nextUpText.x + (_nextUpText.width >> 1) + (_nextUpText.textWidth >> 1) + 2;
         _nextAddTxt.text = "+" + param4;
         _nextAddUpText.text = param6.toString();
         _upArrow2.x = _nextAddUpText.x + (_nextAddUpText.width >> 1) + (_nextAddUpText.textWidth >> 1) + 2;
         if(param6 == 0)
         {
            _nextAddUpText.visible = _upArrow2.visible = false;
         }
         else
         {
            _nextAddUpText.visible = _upArrow2.visible = true;
         }
         if(param7)
         {
            _propertyImg2.visible = false;
            _nextBaseTxt.visible = false;
            _nextUpText.visible = false;
            _nextAddTxt.visible = false;
            _nextAddUpText.visible = false;
            _upArrow.visible = false;
            _upArrow2.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_propertyImg);
         _propertyImg = null;
         ObjectUtils.disposeObject(_preBaseTxt);
         _preBaseTxt = null;
         ObjectUtils.disposeObject(_preAddText);
         _preAddText = null;
         ObjectUtils.disposeObject(_propertyImg2);
         _propertyImg2 = null;
         ObjectUtils.disposeObject(_nextBaseTxt);
         _nextBaseTxt = null;
         ObjectUtils.disposeObject(_nextUpText);
         _nextUpText = null;
         ObjectUtils.disposeObject(_nextAddTxt);
         _nextAddTxt = null;
         ObjectUtils.disposeObject(_nextAddUpText);
         _nextAddUpText = null;
         ObjectUtils.disposeObject(_upArrow);
         _upArrow = null;
         super.dispose();
      }
   }
}

