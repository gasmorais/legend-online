package magicCard.view
{
   import com.greensock.core.TweenCore;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.card.MagicCardInfo;
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.MagicCardManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class MagicCardCell extends Component implements IManualSize
   {
      
      public static const P_backgroundStyle:String = "backgroundStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_nameStyle:String = "nameStyle";
      
      public static const P_levelStyle:String = "levelStyle";
      
      public static const P_levelTxtStyle:String = "levelTxtStyle";
      
      public static const P_expStyle:String = "expStyle";
      
      public static const P_expTxtStyle:String = "expTxtStyle";
      
      public static const P_describeStyle:String = "describeStyle";
      
      public static const P_propertyStyle:String = "propertyStyle";
      
      public static const P_minorStyle:String = "minorStyle";
      
      private var _backgroundStyle:String;
      
      private var _iconStyle:String;
      
      private var _nameStyle:String;
      
      private var _levelStyle:String;
      
      private var _levelTxtStyle:String;
      
      private var _expStyle:String;
      
      private var _expTxtStyle:String;
      
      private var _describeStyle:String;
      
      private var _propertyStyle:String;
      
      private var _minorStyle:String;
      
      private var _sprite:Sprite;
      
      private var _back:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelupMc:MovieClip;
      
      private var _preLvTxt:FilterFrameText;
      
      private var _nextLvTxt:FilterFrameText;
      
      private var _expMC:MovieClip;
      
      private var _expTxt:FilterFrameText;
      
      private var _describeTxt:FilterFrameText;
      
      private var _propertyTxt:FilterFrameText;
      
      private var _minorTxt:FilterFrameText;
      
      private var _oldData:MagicCardInfo;
      
      private var _type:int;
      
      private var _pos:int;
      
      private var _gardes:int;
      
      public var isSelected:Boolean = false;
      
      private var frameIndex:int;
      
      private var _tweenCore:TweenCore;
      
      public function MagicCardCell()
      {
         super();
      }
      
      public function set backgroundStyle(param1:String) : void
      {
         _backgroundStyle = param1;
         onPropertiesChanged("backgroundStyle");
      }
      
      public function set iconStyle(param1:String) : void
      {
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function set nameStyle(param1:String) : void
      {
         _nameStyle = param1;
         onPropertiesChanged("nameStyle");
      }
      
      public function set levelStyle(param1:String) : void
      {
         _levelStyle = param1;
         onPropertiesChanged("levelStyle");
      }
      
      public function set levelTxtStyle(param1:String) : void
      {
         _levelTxtStyle = param1;
         onPropertiesChanged("levelTxtStyle");
      }
      
      public function set expStyle(param1:String) : void
      {
         _expStyle = param1;
         onPropertiesChanged("expStyle");
      }
      
      public function set expTxtStyle(param1:String) : void
      {
         _expTxtStyle = param1;
         onPropertiesChanged("expTxtStyle");
      }
      
      public function set describeStyle(param1:String) : void
      {
         _describeStyle = param1;
         onPropertiesChanged("describeStyle");
      }
      
      public function set propertyStyle(param1:String) : void
      {
         _propertyStyle = param1;
         onPropertiesChanged("propertyStyle");
      }
      
      public function set minorStyle(param1:String) : void
      {
         _minorStyle = param1;
         onPropertiesChanged("minorStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backgroundStyle"])
         {
            _back = ComponentFactory.Instance.creatComponentByStylename(_backgroundStyle);
         }
         if(_changedPropeties["iconStyle"])
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
            _icon = ComponentFactory.Instance.creatCustomObject(_iconStyle);
         }
         if(_changedPropeties["nameStyle"])
         {
            _nameTxt = ComponentFactory.Instance.creatComponentByStylename(_nameStyle);
            _nameTxt.mouseEnabled = false;
         }
         if(_changedPropeties["levelStyle"])
         {
            _levelupMc = ComponentFactory.Instance.creatCustomObject(_levelStyle);
            _levelupMc.gotoAndStop(1);
         }
         if(_changedPropeties["levelTxtStyle"])
         {
            _preLvTxt = ComponentFactory.Instance.creatComponentByStylename(_levelTxtStyle);
            _nextLvTxt = ComponentFactory.Instance.creatComponentByStylename(_levelTxtStyle);
            _levelupMc["pre_txt"].addChild(_preLvTxt);
            _levelupMc["next_txt"].addChild(_nextLvTxt);
         }
         if(_changedPropeties["expStyle"])
         {
            _expMC = ComponentFactory.Instance.creatCustomObject(_expStyle);
            _expMC["halo"].visible = false;
            _expMC.gotoAndStop(1);
         }
         if(_changedPropeties["expTxtStyle"])
         {
            _expTxt = ComponentFactory.Instance.creatComponentByStylename(_expTxtStyle);
            _expTxt.mouseEnabled = false;
         }
         if(_changedPropeties["describeStyle"])
         {
            _describeTxt = ComponentFactory.Instance.creatComponentByStylename(_describeStyle);
            _describeTxt.mouseEnabled = false;
         }
         if(_changedPropeties["propertyStyle"])
         {
            _propertyTxt = ComponentFactory.Instance.creatComponentByStylename(_propertyStyle);
            _propertyTxt.mouseEnabled = false;
         }
         if(_changedPropeties["minorStyle"])
         {
            _minorTxt = ComponentFactory.Instance.creatComponentByStylename(_minorStyle);
            _minorTxt.mouseEnabled = false;
         }
      }
      
      override protected function addChildren() : void
      {
         _sprite = new Sprite();
         if(_icon)
         {
            addChild(_icon);
         }
         addChild(_sprite);
         if(_back)
         {
            _sprite.addChild(_back);
         }
         if(_expMC)
         {
            _sprite.addChild(_expMC);
         }
         if(_nameTxt)
         {
            addChild(_nameTxt);
         }
         if(_levelupMc)
         {
            addChild(_levelupMc);
         }
         if(_propertyTxt)
         {
            addChild(_propertyTxt);
         }
         if(_expTxt)
         {
            addChild(_expTxt);
         }
         if(_describeTxt)
         {
            addChild(_describeTxt);
         }
         if(_minorTxt)
         {
            addChild(_minorTxt);
         }
      }
      
      public function setTypeAndPos(param1:int, param2:int, param3:int) : void
      {
         var _loc7_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:String = null;
         var _loc8_:SkillTempInfo = null;
         _type = param1;
         _pos = param2;
         _gardes = param3;
         var _loc6_:MagicCardTemplateInfo = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(param1,param2,param3);
         _icon.icon = "";
         _preLvTxt.text = "";
         if(_loc6_ == null)
         {
            return;
         }
         _icon.icon = PathManager.getCardIconPath(_loc6_.Icon);
         if(_back)
         {
            _back.setFrame(_loc6_.Profile);
            _back.alpha = 1;
         }
         if(_nameTxt)
         {
            _nameTxt.text = _loc6_.TemplateName;
         }
         if(_preLvTxt)
         {
            if(_loc6_.Profile == 5)
            {
               _preLvTxt.visible = false;
            }
            else
            {
               _preLvTxt.visible = true;
            }
         }
         if(_propertyTxt)
         {
            _propertyTxt.htmlText = "";
            _loc5_ = _loc6_.SkillTempIds.split(",");
            _loc4_ = "";
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc8_ = TempleteManager.instance.getSkillTemplateInfoById(_loc5_[_loc7_]);
               _loc4_ += _loc8_.TemplateName;
               if(_loc7_ < _loc5_.length - 1)
               {
                  _loc4_ += ",";
               }
               _loc7_++;
            }
            _propertyTxt.htmlText = _loc4_;
         }
         if(_describeTxt)
         {
            _describeTxt.text = _loc6_.Description1;
         }
         if(_minorTxt)
         {
            _minorTxt.text = _loc6_.Description2;
         }
         update(MagicCardManager.Instance.cardModel.getInfoByTypeAndPos(param1,param2));
      }
      
      public function set data(param1:MagicCardInfo) : void
      {
      }
      
      public function set setScale(param1:Number) : void
      {
         if(_sprite)
         {
            _sprite.scaleX = param1;
            _sprite.scaleY = param1;
         }
      }
      
      public function set setLevelupScale(param1:Number) : void
      {
         if(_levelupMc)
         {
            _levelupMc.scaleX = param1;
            _levelupMc.scaleY = param1;
         }
      }
      
      public function update(param1:MagicCardInfo) : void
      {
         var _loc3_:Array = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc6_:SkillTempInfo = null;
         if(param1 == null)
         {
            return;
         }
         var _loc7_:String = LanguageMgr.GetTranslation("public.level2",param1.grades);
         _preLvTxt.text = _loc7_;
         var _loc4_:MagicCardTemplateInfo = TempleteManager.instance.magicCardTemplateCate.getTempInfoByTypePosGrades(param1.types,param1.pos,param1.grades);
         if(_propertyTxt)
         {
            _propertyTxt.htmlText = "";
            _loc3_ = _loc4_.SkillTempIds.split(",");
            _loc2_ = "";
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_[_loc5_]);
               _loc2_ += _loc6_.TemplateName;
               if(_loc5_ < _loc3_.length - 1)
               {
                  _loc2_ += ",";
               }
               _loc5_++;
            }
            _propertyTxt.htmlText = _loc2_;
         }
      }
      
      private function __onFinishTween() : void
      {
         disposeTween();
      }
      
      private function disposeTween() : void
      {
         if(_tweenCore)
         {
            _tweenCore.kill();
            _tweenCore = null;
         }
         if(_expMC)
         {
            _expMC["halo"].visible = false;
         }
      }
      
      private function clean() : void
      {
         buttonMode = false;
         mouseEnabled = false;
         mouseChildren = false;
         if(_back)
         {
            _back.alpha = 0;
         }
         if(_icon)
         {
            _icon.icon = null;
         }
         if(_nameTxt)
         {
            _nameTxt.text = "";
         }
         if(_levelupMc)
         {
            _levelupMc.gotoAndStop(1);
         }
         if(_preLvTxt)
         {
            _preLvTxt.text = "";
         }
         if(_nextLvTxt)
         {
            _nextLvTxt.text = "";
         }
         if(_propertyTxt)
         {
            _propertyTxt.text = "";
         }
         if(_expMC)
         {
            _expMC.visible = false;
         }
         if(_expTxt)
         {
            _expTxt.text = "";
         }
         if(_oldData)
         {
            _oldData = null;
         }
      }
      
      public function get expMC() : MovieClip
      {
         return _expMC;
      }
      
      public function get icon() : Object
      {
         return _icon;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,400,510);
      }
      
      override public function dispose() : void
      {
         disposeTween();
         clean();
         filters = null;
         if(_expMC)
         {
            _expMC.stop();
         }
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_levelupMc);
         _levelupMc = null;
         ObjectUtils.disposeObject(_preLvTxt);
         _preLvTxt = null;
         ObjectUtils.disposeObject(_nextLvTxt);
         _nextLvTxt = null;
         ObjectUtils.disposeObject(_expMC);
         _expMC = null;
         ObjectUtils.disposeObject(_describeTxt);
         _describeTxt = null;
         ObjectUtils.disposeObject(_propertyTxt);
         _propertyTxt = null;
         ObjectUtils.disposeObject(_minorTxt);
         _minorTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

