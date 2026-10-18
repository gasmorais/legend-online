package yishi.view.community
{
   import com.greensock.TweenMax;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.LevelUpPrompt;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   
   public class LevelUpView extends Component implements IManualSize
   {
      
      private var _contain:Component;
      
      private var _frameBack:MutipleImage;
      
      private var _roleContain:MovieClip;
      
      private var _figure:Bitmap;
      
      private var _frameBackContain:MovieClip;
      
      private var _levelContain:MovieClip;
      
      private var _levelTxtContain:MovieClip;
      
      private var _levelEffect:MovieClip;
      
      private var _centerSprite:Sprite;
      
      private var _openContain:MovieClip;
      
      private var _vocationTxtStep:ScaleFrameImage;
      
      private var _vocationTxtJob:ScaleFrameImage;
      
      private var _levelNum:BitmapData;
      
      private var _confirmBtn:MovieClip;
      
      private var _movies:Array;
      
      private var _isRemove:Boolean;
      
      private var _isVocation:Boolean;
      
      private var _iconTemp:BaseItemView;
      
      public function LevelUpView(param1:Boolean = false)
      {
         _isVocation = param1;
         super();
         initView();
         initAttribute();
         initOpenlist();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(ArmyManager.instance.thane.templateId == 100)
         {
            return new Rectangle(0,0,1000,310);
         }
         return new Rectangle(0,0,1000,360);
      }
      
      private function initView() : void
      {
         mouseEnabled = false;
         _contain = ComponentFactory.Instance.creatComponentByStylename("playerlevelup.LelveUpLevelBack");
         _frameBack = ComponentFactory.Instance.creatComponentByStylename("playerlevelup.LelveUpLevelBack0");
         _roleContain = ComponentFactory.Instance.creat("asset.playerlevelup.RoleContainer");
         _figure = ComponentFactory.Instance.creatBitmap("asset.playerlevelup.Human_" + thane.templateId);
         _frameBackContain = ComponentFactory.Instance.creat("asset.playerlevelup.LelveUpFrameContain");
         if(_isVocation)
         {
            _levelContain = ComponentFactory.Instance.creat("asset.playerlevelup.LelveUpVocationContain");
         }
         else
         {
            _levelContain = ComponentFactory.Instance.creat("asset.playerlevelup.LelveUpLevelContain");
         }
         _confirmBtn = ComponentFactory.Instance.creat("asset.playerlevelup.LevelUpConfirmBtnBack");
         _levelTxtContain = ComponentFactory.Instance.creat("asset.playerlevelup.LelveUpLeveltxtContain");
         _levelEffect = ComponentFactory.Instance.creat("asset.playerlevelup.LelveUpLevelEffect");
         _openContain = ComponentFactory.Instance.creat("asset.playerlevelup.LelveUpOpenContain");
         _centerSprite = new Sprite();
         _contain.addChild(_frameBack);
         _frameBackContain["container"].addChild(_contain);
         _confirmBtn.buttonMode = true;
         _frameBackContain.x = 324;
         _frameBackContain.y = 66;
         if(_isVocation)
         {
            _levelContain.x = 518;
            _levelContain.y = 48;
            _levelTxtContain.x = 553;
            _levelTxtContain.y = 25;
         }
         else
         {
            _levelContain.x = 428;
            _levelContain.y = 48;
            _levelTxtContain.x = 610;
            _levelTxtContain.y = -32;
         }
         _confirmBtn.x = 526;
         _confirmBtn.y = 239;
         _openContain.x = 447;
         _openContain.y = 160;
         _levelEffect.x = 563;
         _levelEffect.y = 42;
         _roleContain.x = 173;
         _roleContain.y = -70;
         _roleContain["container"].addChild(_figure);
         _roleContain.gotoAndStop(1);
         _frameBackContain.gotoAndStop(1);
         _levelContain.gotoAndStop(1);
         _confirmBtn.gotoAndStop(1);
         _levelTxtContain.gotoAndStop(1);
         _openContain.gotoAndStop(1);
         _levelEffect.gotoAndStop(1);
         addChild(_frameBackContain);
         addChild(_levelEffect);
         addChild(_levelContain);
         addChild(_roleContain);
         addChild(_confirmBtn);
         addChild(_centerSprite);
         _centerSprite.addChild(_openContain);
         _levelNum = ComponentFactory.Instance.creatBitmapData("asset.core.LevelUpNumber").clone();
         if(_isVocation)
         {
            _vocationTxtStep = ComponentFactory.Instance.creatComponentByStylename("playerlevelup.LevelUpVocationTxtStep");
            _vocationTxtJob = ComponentFactory.Instance.creatComponentByStylename("playerlevelup.LevelUpVocationTxtJob" + thane.templateInfo.Job);
            _vocationTxtStep.setFrame(playerInfo.vocationStep);
            _vocationTxtJob.setFrame(playerInfo.vocationLevel);
            _vocationTxtStep.x = -(_vocationTxtStep.width + _vocationTxtJob.width) * 0.5;
            _vocationTxtJob.x = _vocationTxtStep.x + _vocationTxtStep.width;
            _levelTxtContain.contain.addChild(_vocationTxtStep);
            _levelTxtContain.contain.addChild(_vocationTxtJob);
         }
         else
         {
            NumberViewUtils.refreshValue(thane.grades,_levelTxtContain.contain,_levelNum,56,64,50,56,"0123456789");
            if(thane.grades >= 10)
            {
               _levelTxtContain.x = 582;
            }
            else
            {
               _levelTxtContain.x = 610;
            }
         }
         addChild(_levelTxtContain);
      }
      
      private function initOpenlist() : void
      {
         var _loc6_:XML = null;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:BaseItemView = null;
         _openContain["content"]["open_txt"].visible = false;
         _openContain["content"]["function_txt"].visible = false;
         _centerSprite.y = 33;
         var _loc3_:XMLList = LevelUpPrompt.PromptXml..story;
         var _loc4_:int = _loc3_.length();
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            if(_loc3_[_loc7_].@grade == thane.grades)
            {
               _loc6_ = _loc3_[_loc7_];
               break;
            }
            _loc7_++;
         }
         if(!_loc6_)
         {
            return;
         }
         var _loc1_:String = "";
         _loc3_ = _loc6_.item;
         _loc4_ = _loc3_.length();
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            if(_loc3_[_loc7_].@type == "0")
            {
               if(_loc1_ != "")
               {
                  _loc1_ += ",";
               }
               _loc1_ += _loc3_[_loc7_].@name;
               _centerSprite.y = 15;
            }
            if(_loc3_[_loc7_].@type == "1")
            {
               _openContain["content"]["function_txt"].visible = true;
               _openContain["content"]["function_txt"].x = 10;
               _loc5_ = ComponentFactory.Instance.creatCustomObject("playerlevelup.LevelUpItem");
               _loc5_.scaleX = _loc5_.scaleY = 0.7;
               _loc5_.icon.icon = IconFactory.getCommonIconPath("/upgradeTip/" + _loc3_[_loc7_].@url);
               _loc5_.tipData = _loc3_[_loc7_].@tip;
               _openContain["content"].addChild(_loc5_);
               _loc5_.y = 20;
               _loc5_.x = 52 * _loc2_ + 80;
               _loc2_++;
               _centerSprite.y = 0;
            }
            _loc7_++;
         }
         if(_loc1_ != "")
         {
            _openContain["content"]["open_txt"].visible = true;
         }
         _openContain["content"]["open_txt"].x = 10;
         _openContain["content"]["open_txt"]["txt"].text = _loc1_;
      }
      
      private function initAttribute() : void
      {
         _movies = [];
         var _loc1_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01") + ":";
         if(thane.templateInfo.Job == 1)
         {
            refreshAttribute(1,_loc1_,(thane.grades - thane.preGrade) * 2);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02") + ":";
            refreshAttribute(2,_loc1_,(thane.grades - thane.preGrade) * 1);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04") + ":";
            refreshAttribute(3,_loc1_,(thane.grades - thane.preGrade) * 2);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05") + ":";
            refreshAttribute(4,_loc1_,(thane.grades - thane.preGrade) * 10);
         }
         else if(thane.templateInfo.Job == 2)
         {
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01") + ":";
            refreshAttribute(1,_loc1_,(thane.grades - thane.preGrade) * 3);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02") + ":";
            refreshAttribute(2,_loc1_,(thane.grades - thane.preGrade) * 1);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04") + ":";
            refreshAttribute(3,_loc1_,(thane.grades - thane.preGrade) * 1);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05") + ":";
            refreshAttribute(4,_loc1_,(thane.grades - thane.preGrade) * 10);
         }
         else if(thane.templateInfo.Job == 3)
         {
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03") + ":";
            refreshAttribute(1,_loc1_,(thane.grades - thane.preGrade) * 3);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02") + ":";
            refreshAttribute(2,_loc1_,(thane.grades - thane.preGrade) * 1);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04") + ":";
            refreshAttribute(3,_loc1_,(thane.grades - thane.preGrade) * 1);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05") + ":";
            refreshAttribute(4,_loc1_,(thane.grades - thane.preGrade) * 10);
         }
         else if(thane.templateInfo.Job == 100)
         {
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01") + ":";
            refreshAttribute(1,_loc1_,(thane.grades - thane.preGrade) * 2);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02") + ":";
            refreshAttribute(2,_loc1_,(thane.grades - thane.preGrade) * 1);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03") + ":";
            refreshAttribute(3,_loc1_,(thane.grades - thane.preGrade) * 2);
            _loc1_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04") + ":";
            refreshAttribute(4,_loc1_,(thane.grades - thane.preGrade) * 10);
         }
      }
      
      private function refreshAttribute(param1:int, param2:String, param3:int) : void
      {
         var _loc4_:MovieClip = ComponentFactory.Instance.creat("asset.playerlevelup.LevelUpAttribute_" + param1);
         var _loc6_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("playerlevelup.LevelUpAddPropName");
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("playerlevelup.LevelUpAddPropValue");
         _loc6_.text = param2;
         _loc5_.text = "+" + param3;
         _loc4_["content"].addChild(_loc6_);
         _loc4_["content"].addChild(_loc5_);
         if(param1 == 1)
         {
            _loc4_.x = 444;
            _loc4_.y = 94;
         }
         else if(param1 == 2)
         {
            _loc4_.x = 576;
            _loc4_.y = 94;
         }
         else if(param1 == 3)
         {
            _loc4_.x = 444;
            _loc4_.y = 124;
         }
         else
         {
            _loc4_.x = 576;
            _loc4_.y = 124;
         }
         _movies.push(_loc4_);
         _centerSprite.addChild(_loc4_);
      }
      
      private function playAction() : void
      {
         _roleContain.gotoAndPlay(1);
         _frameBackContain.gotoAndPlay(1);
         _levelContain.gotoAndPlay(1);
         _confirmBtn.gotoAndPlay(1);
         _levelTxtContain.gotoAndPlay(1);
         _openContain.gotoAndPlay(1);
         _levelEffect.gotoAndPlay(1);
      }
      
      private function initEvent() : void
      {
         _confirmBtn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispatchEvent(new Event("close"));
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,true);
         playAction();
      }
      
      public function stop() : void
      {
         _roleContain.stop();
         _frameBackContain.stop();
         _levelContain.stop();
         _levelTxtContain.stop();
         _confirmBtn.stop();
         _roleContain["container"].stop();
         _levelEffect.stop();
         _openContain.stop();
      }
      
      public function play() : void
      {
         _roleContain.play();
         _frameBackContain.play();
         _levelContain.play();
         _levelTxtContain.play();
         _confirmBtn.play();
         _roleContain["container"].play();
         _levelEffect.play();
         _openContain.play();
      }
      
      public function tweenToDispose() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         _isRemove = true;
         removeEvent();
         childDispose();
         if(_roleContain)
         {
            ObjectUtils.disposeViolentMc(_roleContain);
         }
         _roleContain = null;
         if(_frameBackContain)
         {
            ObjectUtils.disposeViolentMc(_frameBackContain);
         }
         _frameBackContain = null;
         if(_levelContain)
         {
            ObjectUtils.disposeViolentMc(_levelContain);
         }
         _levelContain = null;
         if(_levelTxtContain)
         {
            ObjectUtils.disposeViolentMc(_levelTxtContain);
         }
         _levelTxtContain = null;
         if(_vocationTxtStep)
         {
            ObjectUtils.disposeObject(_vocationTxtStep);
         }
         _vocationTxtStep = null;
         if(_vocationTxtJob)
         {
            ObjectUtils.disposeObject(_vocationTxtJob);
         }
         _vocationTxtJob = null;
         if(_levelNum)
         {
            ObjectUtils.disposeObject(_levelNum);
         }
         _levelNum = null;
         if(_confirmBtn)
         {
            ObjectUtils.disposeViolentMc(_confirmBtn);
         }
         _confirmBtn = null;
         if(_figure)
         {
            ObjectUtils.disposeObject(_figure);
         }
         _figure = null;
         if(_levelEffect)
         {
            ObjectUtils.disposeViolentMc(_levelEffect);
         }
         _levelEffect = null;
         if(_openContain)
         {
            ObjectUtils.disposeViolentMc(_openContain);
         }
         _openContain = null;
         for each(var _loc1_:MovieClip in _movies)
         {
            ObjectUtils.disposeViolentMc(_loc1_);
            _loc1_ = null;
         }
         _movies = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         TweenMax.killTweensOf(this);
      }
      
      private function childDispose() : void
      {
         if(_frameBack)
         {
            if(_frameBack.parent)
            {
               _frameBack.parent.removeChild(_frameBack);
            }
            _frameBack.dispose();
            _frameBack = null;
         }
         if(_contain)
         {
            if(_contain.parent)
            {
               _contain.parent.removeChild(_contain);
            }
            _contain.dispose();
            _contain = null;
         }
      }
   }
}

