package ancientartifact.view
{
   import ancientartifact.view.item.AncientStarsItem;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   
   public class AncientMiddleView extends Component
   {
      
      private var _templateId:int;
      
      private var _template:ArtifactTemplateInfo;
      
      private var _data:AncientArtifactInfo;
      
      private var _rareweaponName:FilterFrameText;
      
      private var _equipBtn:IconButton;
      
      private var _unEquipBtn:IconButton;
      
      private var _arrowBtn:BaseButton;
      
      private var _showBgMask:Shape;
      
      private var _showContainer:Sprite;
      
      private var _stars:AncientStarsItem;
      
      private var _filter:UIFilter;
      
      private var _summonBtn:BaseButton;
      
      private var _summonGoodsName:FilterFrameText;
      
      private var _fallLinkSprite:Component;
      
      private var _fallLinkTxt:FilterFrameText;
      
      private var _middleContain:Component;
      
      private var _lvlText:FilterFrameText;
      
      private var _fightValue:int;
      
      private var _fightText:Bitmap;
      
      private var _fightBmp:Bitmap;
      
      private var _fightMc:MovieClip;
      
      private var _playFightMc:Boolean = false;
      
      public function AncientMiddleView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:ComponentFactory = ComponentFactory.Instance;
         _rareweaponName = _loc2_.creatComponentByStylename("ancientartifact.propertyView.rareweaponName");
         _equipBtn = _loc2_.creatComponentByStylename("ancientartifact.equipBtn");
         _unEquipBtn = _loc2_.creatComponentByStylename("ancientartifact.unEquipBtn");
         _arrowBtn = _loc2_.creatComponentByStylename("ancientartifact.advanceArrowBtn");
         _summonBtn = _loc2_.creatComponentByStylename("ancientartifact.propertyView.summonBtn");
         _summonGoodsName = _loc2_.creatComponentByStylename("ancientartifact.propertyView.needGoodsName");
         _fallLinkSprite = ComponentFactory.Instance.creatCustomObject("ancientartifact.fallItemsLinkTxt.Sprite");
         _fallLinkTxt = ComponentFactory.Instance.creatComponentByStylename("ancientMiddleView.fallItemsLinkTxt");
         _middleContain = new Component();
         _fightText = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.fightTxt");
         _fightBmp = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.fightNum");
         _fightMc = ComponentFactory.Instance.creat("asset.core.powerMc");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("ancientMiddleView.lvlText");
         _showContainer = new Sprite();
         _showContainer.x = 170;
         _showContainer.y = 230;
         _filter = new UIFilter();
         _showBgMask = new Shape();
         _showBgMask.graphics.beginFill(16777215,0);
         _showBgMask.graphics.drawRect(0,0,372,426);
         _showBgMask.graphics.endFill();
         _showBgMask.x = 0;
         _showBgMask.y = 0;
         _showContainer.mask = _showBgMask;
         addChild(_middleContain);
         _middleContain.addChild(_showContainer);
         _middleContain.addChild(_showBgMask);
         _middleContain.addChild(_rareweaponName);
         _middleContain.addChild(_equipBtn);
         _middleContain.addChild(_unEquipBtn);
         _middleContain.addChild(_arrowBtn);
         _middleContain.addChild(_lvlText);
         addChild(_summonBtn);
         addChild(_fallLinkSprite);
         _fallLinkSprite.addChild(_fallLinkTxt);
         _middleContain.addChild(_summonGoodsName);
         _middleContain.addChild(_fightText);
         _middleContain.addChild(_fightMc);
         _fightMc.x = 180;
         _fightMc.y = 377;
         _showContainer.mouseEnabled = _showContainer.mouseChildren = false;
         var _loc1_:String = LanguageMgr.GetTranslation("AncientMiddleView.fallLink");
         _fallLinkTxt.htmlText = "<a href =\'event: \'><u><b>" + _loc1_ + " </b></u></a>";
         _fallLinkTxt.mouseEnabled = true;
      }
      
      private function initEvent() : void
      {
         _equipBtn.addEventListener("click",__equipHandler);
         _unEquipBtn.addEventListener("click",__unEquipHandler);
         _arrowBtn.addEventListener("click",__advanceHandler);
         _summonBtn.addEventListener("click",__summonHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_equipBtn)
         {
            _equipBtn.removeEventListener("click",__equipHandler);
         }
         if(_unEquipBtn)
         {
            _unEquipBtn.removeEventListener("click",__unEquipHandler);
         }
         if(_arrowBtn)
         {
            _arrowBtn.removeEventListener("click",__advanceHandler);
         }
         if(_summonBtn)
         {
            _summonBtn.removeEventListener("click",__summonHandler);
         }
         NotificationManager.instance.removeEventListener("ARTIFACT_ITEM_CLICK",__itemClickHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_INFO_UPDATE",__updateViewHandler);
      }
      
      private function __equipHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.EQUIP,_templateId,0,true);
      }
      
      private function __unEquipHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.EQUIP,_templateId,0,false);
      }
      
      private function __advanceHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("ancientartifact",1,_template.TemplateId);
      }
      
      private function __summonHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.SUMMON,_templateId);
      }
      
      private function __itemClickHandler(param1:NotificationEvent) : void
      {
         __updateViewHandler(null);
      }
      
      private function __updateViewHandler(param1:NotificationEvent = null) : void
      {
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc4_:int = 0;
         _templateId = AncientArtifactManager.instance.selectTempId;
         _template = TempleteManager.instance.artifactTemplateCate.getTemplateById(_templateId);
         _data = model.getArtifactInfoById(_templateId);
         clearData();
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_template.NeedItem);
         var _loc5_:int = int(GoodsManager.instance.getBagCountByTempId(1,_template.NeedItem));
         _summonGoodsName.text = LanguageMgr.GetTranslation("ancientartifact.AncientArtifactFrame.summonGoodsName",_loc2_.TemplateName);
         _summonGoodsName.visible = !_data;
         _summonBtn.visible = !_data;
         _summonBtn.enable = _loc5_ > 0;
         _rareweaponName.text = _template.TemplateName;
         _equipBtn.enable = !!_data;
         _unEquipBtn.enable = !!_data;
         _arrowBtn.enable = !!_data;
         _summonBtn.visible = !_data;
         _equipBtn.visible = _data && !_data.isEquip;
         _unEquipBtn.visible = _data && _data.isEquip;
         _fallLinkSprite.tipData = {
            "type":"max",
            "tempInfo":_template
         };
         _stars = new AncientStarsItem(_template,_data);
         _stars.x = 123;
         _stars.y = 44;
         addChild(_stars);
         startLoader(_template);
         if(_data)
         {
            _lvlText.text = LanguageMgr.GetTranslation("public.level2",_data.level);
            setFightNumberView(_data.fightPower + armoryResonateAddFightPower);
            _filter.setNormalFilter(_middleContain);
            _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(_data.level,136);
            if(_loc3_)
            {
               _arrowBtn.tipData = LanguageMgr.GetTranslation("ancientartifact.advanceArrowBtn.tipdata",_loc3_.ActiveObject);
            }
         }
         else
         {
            _lvlText.text = "";
            _loc4_ = _template.AttackMin + _template.DefenceMin + int(_template.MagicAttackMin * 1.05) + _template.MagicDefenceMin + _template.LiveMin / 5 + _template.ParryMin + _template.PenetrateMin;
            setFightNumberView(_loc4_);
            _filter.setGrayFilter(_middleContain);
            _arrowBtn.tipData = null;
         }
      }
      
      private function get armoryResonateAddFightPower() : int
      {
         var _loc8_:AncientArmoryInfo = null;
         var _loc3_:AncientArtifactInfo = null;
         var _loc2_:AncientResonateInfo = null;
         var _loc7_:UpgradeTemplateInfo = null;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Array = [0,0,0,0,0,0,0];
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            _loc9_ = int(_data ? _data["armoryEquipPos" + (_loc6_ + 1)] : 0);
            _loc8_ = model.getArmoryInfoById(_loc9_);
            if(_loc9_ > 0 && _loc8_)
            {
               var _loc10_:* = 0;
               var _loc11_:* = _loc1_[_loc10_] + _loc8_.attacks;
               _loc1_[_loc10_] = _loc11_;
               _loc1_[1] += _loc8_.defences;
               _loc1_[2] += _loc8_.attacks;
               _loc1_[3] += _loc8_.magicDefences;
               _loc1_[4] += _loc8_.penetrate;
               _loc1_[5] += _loc8_.parry;
               _loc1_[6] += _loc8_.live;
            }
            if(_loc6_ < 5)
            {
               _loc5_ = int(_data ? _data["slotedEquipPos" + (_loc6_ + 1)] : 0);
               _loc3_ = model.getArtifactInfoById(_loc5_);
               _loc2_ = model.getResonateInfoByPos(_loc6_ + 1);
               if(_loc5_ > 0 && _loc3_ && _loc2_)
               {
                  _loc7_ = TempleteManager.instance.getTemplateByLevelAndType(_loc2_.posGrades,137);
                  if(_loc6_ == 0)
                  {
                     _loc11_ = 0;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc3_.attack / 100);
                     _loc1_[_loc11_] = _loc10_;
                     _loc1_[2] += Math.floor(_loc7_.ActiveObject * _loc3_.magicAttack / 100);
                  }
                  else if(_loc6_ == 1)
                  {
                     _loc11_ = 1;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc3_.defences / 100);
                     _loc1_[_loc11_] = _loc10_;
                     _loc1_[3] += Math.floor(_loc7_.ActiveObject * _loc3_.magicDefences / 100);
                  }
                  else if(_loc6_ == 2)
                  {
                     _loc11_ = 5;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc3_.parry / 100);
                     _loc1_[_loc11_] = _loc10_;
                  }
                  else if(_loc6_ == 3)
                  {
                     _loc10_ = 4;
                     _loc11_ = _loc1_[_loc10_] + Math.floor(_loc7_.ActiveObject * _loc3_.penetrate / 100);
                     _loc1_[_loc10_] = _loc11_;
                  }
                  else if(_loc6_ == 4)
                  {
                     _loc11_ = 6;
                     _loc10_ = _loc1_[_loc11_] + Math.floor(_loc7_.ActiveObject * _loc3_.live / 100);
                     _loc1_[_loc11_] = _loc10_;
                  }
               }
            }
            _loc6_ += 1;
         }
         return int(_loc1_[0] + _loc1_[1] + int(_loc1_[2] * 1.05) + _loc1_[3] + _loc1_[4] + _loc1_[5] + _loc1_[6]);
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      private function clearData() : void
      {
         var _loc1_:DisplayObject = null;
         while(_showContainer && _showContainer.numChildren > 0)
         {
            _loc1_ = _showContainer.getChildAt(0);
            _showContainer.removeChild(_loc1_);
         }
         _rareweaponName.text = "";
         _summonGoodsName.text = "";
         ObjectUtils.disposeObject(_stars);
         _stars = null;
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rareweaponName);
         _rareweaponName = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_unEquipBtn);
         _unEquipBtn = null;
         ObjectUtils.disposeObject(_arrowBtn);
         _arrowBtn = null;
         ObjectUtils.disposeObject(_showBgMask);
         _showBgMask = null;
         ObjectUtils.disposeAllChildren(_showContainer);
         ObjectUtils.disposeObject(_showContainer);
         _showContainer = null;
         ObjectUtils.disposeObject(_stars);
         _stars = null;
         ObjectUtils.disposeObject(_summonBtn);
         _summonBtn = null;
         ObjectUtils.disposeObject(_summonGoodsName);
         _summonGoodsName = null;
         ObjectUtils.disposeObject(_fallLinkSprite);
         _fallLinkSprite = null;
         ObjectUtils.disposeObject(_fallLinkTxt);
         _fallLinkTxt = null;
         ObjectUtils.disposeObject(_middleContain);
         _middleContain = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeObject(_fightBmp);
         _fightBmp = null;
         ObjectUtils.disposeViolentMc(_fightMc);
         _fightMc = null;
         ObjectUtils.disposeObject(_lvlText);
         _lvlText = null;
         _filter = null;
         _template = null;
         _data = null;
         super.dispose();
      }
   }
}

