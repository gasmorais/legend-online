package ancientartifact
{
   import ancientartifact.view.item.AncientStarsItem;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.playerinfo.ArtifactThaneInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   
   public class AncientEquipFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _info:ArtifactThaneInfo;
      
      private var _templateId:int;
      
      private var _template:ArtifactTemplateInfo;
      
      private var _middleContain:Component;
      
      private var _showBgMask:Shape;
      
      private var _showContainer:Sprite;
      
      private var _rareweaponName:FilterFrameText;
      
      private var _stars:AncientStarsItem;
      
      private var _data:AncientArtifactInfo;
      
      private var _fightValue:int;
      
      private var _fightText:Bitmap;
      
      private var _fightBmp:Bitmap;
      
      private var _fightMc:MovieClip;
      
      private var _propertyView:AncientCheckPropertyView;
      
      private var _playFightMc:Boolean = false;
      
      public function AncientEquipFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.middleBg");
         _rareweaponName = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.propertyView.rareweaponName");
         _middleContain = new Component();
         _fightText = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.fightTxt");
         _fightBmp = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.fightNum");
         _fightMc = ComponentFactory.Instance.creat("asset.core.powerMc");
         _showContainer = new Sprite();
         _showContainer.x = 170;
         _showContainer.y = 230;
         _showBgMask = new Shape();
         _showBgMask.graphics.beginFill(16777215,0);
         _showBgMask.graphics.drawRect(0,0,372,426);
         _showBgMask.graphics.endFill();
         _showBgMask.x = 0;
         _showBgMask.y = 0;
         _showContainer.mask = _showBgMask;
         addToContent(_bg);
         _bg.x = 0;
         _bg.y = 0;
         addToContent(_middleContain);
         _middleContain.addChild(_showContainer);
         _middleContain.addChild(_showBgMask);
         _middleContain.addChild(_rareweaponName);
         _middleContain.addChild(_fightText);
         _middleContain.addChild(_fightMc);
         _fightMc.x = 180;
         _fightMc.y = 377;
         _showContainer.mouseEnabled = _showContainer.mouseChildren = false;
         _propertyView = new AncientCheckPropertyView();
         addToContent(_propertyView);
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         _propertyView.info = _info;
         if(_info)
         {
            _templateId = _info.templateId;
            _data = new AncientArtifactInfo();
            _data.level = _info.level;
            _data.fightPower = _info.fightPower;
         }
         else
         {
            _data = model.getEquipArtifactInfo();
            _templateId = _data.templateId;
         }
         _template = TempleteManager.instance.artifactTemplateCate.getTemplateById(_templateId);
         _rareweaponName.text = _template.TemplateName;
         _stars = new AncientStarsItem(_template,_data);
         _stars.x = 123;
         _stars.y = 44;
         addToContent(_stars);
         startLoader(_template);
         if(_data)
         {
            setFightNumberView(_data.fightPower);
         }
         else
         {
            _loc1_ = _template.AttackMin + _template.DefenceMin + int(_template.MagicAttackMin * 1.05) + _template.MagicDefenceMin + _template.LiveMin / 5 + _template.ParryMin + _template.PenetrateMin;
            setFightNumberView(_loc1_);
         }
      }
      
      private function startLoader(param1:ArtifactTemplateInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:String = PathManager.getArtifactShowPath(param1.SonType);
         LoaderManagerII.instance.load(_loc2_,2,8,__loadMorphAvatarCompleteHandler);
      }
      
      private function __loadMorphAvatarCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:DisplayObject = null;
         if(isDie)
         {
            return;
         }
         while(_showContainer.numChildren > 0)
         {
            _loc4_ = _showContainer.getChildAt(0);
            _showContainer.removeChild(_loc4_);
         }
         var _loc3_:MovieClip = param2 as MovieClip;
         if(_loc3_)
         {
            if(_loc3_["pos_down"])
            {
               _loc3_.x = -_loc3_["pos_down"]["x"];
               _loc3_.y = -_loc3_["pos_down"]["y"];
            }
            if(_showContainer)
            {
               _showContainer.addChild(_loc3_);
            }
            if(_data)
            {
               _loc3_.play();
            }
            else
            {
               _loc3_.stop();
            }
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
         }
      }
      
      private function setFightNumberView(param1:int = 0) : void
      {
         if(_fightValue == param1)
         {
            return;
         }
         _fightText.x = (296 - getNumWidth(param1)) / 2;
         _fightMc.x = _fightText.x + 80;
         if(!_playFightMc)
         {
            NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
            _fightMc.gotoAndStop(24);
            _fightValue = param1;
            _playFightMc = true;
            return;
         }
         if(_fightValue > 0)
         {
            NumberViewUtils.getNumberView(_fightValue,_fightMc["old_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         }
         NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         _fightMc.gotoAndPlay(1);
         _fightValue = param1;
      }
      
      private function getNumWidth(param1:int) : int
      {
         var _loc2_:String = null;
         _loc2_ = param1 + "";
         return _loc2_.length * 19;
      }
      
      public function set data(param1:ArtifactThaneInfo) : void
      {
         _info = param1;
         refreshView();
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_middleContain);
         _middleContain = null;
         ObjectUtils.disposeObject(_showBgMask);
         _showBgMask = null;
         ObjectUtils.disposeObject(_showContainer);
         _showContainer = null;
         ObjectUtils.disposeObject(_rareweaponName);
         _rareweaponName = null;
         ObjectUtils.disposeObject(_stars);
         _stars = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeObject(_fightBmp);
         _fightBmp = null;
         ObjectUtils.disposeViolentMc(_fightMc);
         _fightMc = null;
         _info = null;
         _data = null;
         super.dispose();
      }
   }
}

