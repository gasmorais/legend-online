package armyII.viewII.tattoo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import mvc.module.task.TaskTemplate;
   import mvc.module.tattoo.TattooHole;
   import mvc.module.tattoo.TattooHoleInfoII;
   import mvc.module.tattoo.TattooModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TattooView extends Sprite implements Disposeable
   {
      
      private var _mainBack:Scale9CornerImage;
      
      private var _mainBg:Image;
      
      private var _tattooIcon:Image;
      
      private var holes:Array;
      
      private var _effect:MovieClip;
      
      private var _helpBtn:BaseButton;
      
      private var _buttonMc1:MovieClip;
      
      private var _lockImage:MutipleImage;
      
      private var _imprintBtn:BaseButton;
      
      private var _imprintImage:Image;
      
      private const postion:Array = [[50,55],[275,53],[16,135],[308,135],[16,225],[310,225],[40,313],[295,310]];
      
      private var _filter:IFilterFormat;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _isSelf:Boolean;
      
      public function TattooView(param1:Boolean = true, param2:ThaneInfo = null)
      {
         _isSelf = param1;
         _thaneInfo = param2;
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc6_:int = 0;
         var _loc1_:TattooHoleView = null;
         var _loc2_:String = null;
         _filter = new UIFilter();
         _mainBack = ComponentFactory.Instance.creatComponentByStylename("army.TattooBack");
         _mainBg = ComponentFactory.Instance.creatComponentByStylename("tattoo.mainBg");
         _tattooIcon = ComponentFactory.Instance.creatComponentByStylename("tattoo.TattooIcon");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("tattoo.helpBtn");
         _buttonMc1 = ComponentFactory.Instance.creatCustomObject("TattooView.shineMc");
         _lockImage = ComponentFactory.Instance.creatComponentByStylename("TattooView.lockImage");
         _imprintBtn = ComponentFactory.Instance.creatComponentByStylename("TattooView.imprintBtn");
         _imprintImage = ComponentFactory.Instance.creatComponentByStylename("TattooView.imprintImage");
         var _loc4_:ThaneInfo = ArmyManager.instance.thane;
         if(!_isSelf)
         {
            _loc4_ = _thaneInfo;
         }
         var _loc5_:int = int(_loc4_.templateInfo.Sexs);
         _effect = ComponentFactory.Instance.creat("asset.tattoo.tattooEffect" + _loc5_);
         addChild(_mainBack);
         addChild(_mainBg);
         addChild(_effect);
         if(_loc5_ == 0)
         {
            _effect.scaleX = 0.9;
            _effect.scaleY = 0.9;
            _effect.x = 169;
            _effect.y = 208;
         }
         else if(_loc5_ == 1)
         {
            _effect.scaleX = 0.92;
            _effect.scaleY = 0.92;
            _effect.x = 97;
            _effect.y = 217;
         }
         addChild(_tattooIcon);
         addChild(_helpBtn);
         addChild(_lockImage);
         addChild(_imprintBtn);
         addChild(_imprintImage);
         _imprintImage.visible = false;
         holes = [];
         var _loc3_:Array = FrameControllerManager.instance.tattooController.tattooModel.holes;
         if(!_isSelf)
         {
            _loc3_ = _thaneInfo.holes;
         }
         if(!_loc3_)
         {
            _loc3_ = [];
         }
         _loc6_ = 0;
         while(_loc6_ < 8)
         {
            _loc1_ = new TattooHoleView(_loc6_,_isSelf,_thaneInfo);
            _loc1_.x = postion[_loc6_][0];
            _loc1_.y = postion[_loc6_][1];
            _loc1_.tipStyle = "yishi.view.tips.OneLineTip";
            _loc1_.isFollowMouse = false;
            _loc1_.tipDirctions = "2,1";
            if(_loc6_ < _loc3_.length)
            {
               if(_isSelf)
               {
                  _loc1_.addEventListener("click",holeClickHandle);
                  _loc1_.addEventListener("mouseOver",holeOverHandle);
                  _loc1_.addEventListener("mouseOut",holeOutHandle);
                  _loc1_.tipData = LanguageMgr.GetTranslation("tattoo.TattooFrame.clickToRefresh");
               }
               else
               {
                  _loc1_.tipData = "";
               }
            }
            else
            {
               _loc2_ = PlayerManager.instance.getShortVocationName(_loc4_.templateInfo.Job,_loc6_ + 1);
               _loc1_.tipData = LanguageMgr.GetTranslation("tattoo.TattooFrame.lvlToUnlock",_loc2_);
            }
            if(_loc6_ == 0)
            {
               _buttonMc1["pos"].addChild(_loc1_);
            }
            else
            {
               addChild(_loc1_);
            }
            holes.push(_loc1_);
            _loc6_++;
         }
         if(FrameControllerManager.instance.tattooController.tattooModel.missionType == 0)
         {
            _buttonMc1.gotoAndStop(1);
         }
         addChild(_buttonMc1);
      }
      
      private function holeOutHandle(param1:MouseEvent) : void
      {
         var _loc2_:TattooHoleView = param1.currentTarget as TattooHoleView;
         _filter.setNormalFilter(_loc2_);
         Mouse.cursor = "auto";
      }
      
      private function holeOverHandle(param1:MouseEvent) : void
      {
         var _loc2_:TattooHoleView = param1.currentTarget as TattooHoleView;
         _filter.setLightingFilter(_loc2_);
         Mouse.cursor = "button";
      }
      
      private function holeClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:TattooHoleView = param1.currentTarget as TattooHoleView;
         FrameControllerManager.instance.tattooController.tattooModel.currHoleIndex = _loc2_.index;
         FrameControllerManager.instance.tattooController.openPopFrame();
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("tattoo.helpFrame");
         _loc2_.show();
      }
      
      private function __imprintClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:TattooImprintFrame = ComponentFactory.Instance.creatComponentByStylename("tattoo.TattooImprintFrame");
         _loc2_.show();
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc1_:String = null;
         if(FrameControllerManager.instance.tattooController.tattooModel.lastOpType == 2 || FrameControllerManager.instance.tattooController.tattooModel.lastOpType == 3)
         {
            _buttonMc1.gotoAndStop(1);
            FrameControllerManager.instance.tattooController.tattooModel.missionType = 0;
         }
         var _loc2_:Array = FrameControllerManager.instance.tattooController.tattooModel.holes;
         if(!_isSelf)
         {
            _loc2_ = _thaneInfo.holes;
         }
         if(!_loc2_)
         {
            _loc2_ = [];
         }
         var _loc3_:ThaneInfo = ArmyManager.instance.thane;
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            if(_loc4_ < _loc2_.length)
            {
               if(_isSelf)
               {
                  holes[_loc4_].addEventListener("click",holeClickHandle);
                  holes[_loc4_].addEventListener("mouseOver",holeOverHandle);
                  holes[_loc4_].addEventListener("mouseOut",holeOutHandle);
                  holes[_loc4_].tipData = LanguageMgr.GetTranslation("tattoo.TattooFrame.clickToRefresh");
               }
               else
               {
                  holes[_loc4_].tipData = "";
               }
            }
            else
            {
               _loc1_ = PlayerManager.instance.getShortVocationName(_loc3_.templateInfo.Job,_loc4_ + 1);
               holes[_loc4_].tipData = LanguageMgr.GetTranslation("tattoo.TattooFrame.lvlToUnlock",_loc1_);
            }
            (holes[_loc4_] as TattooHoleView).refresh();
            _effect["effect" + (_loc4_ + 1)].visible = false;
            if(_loc4_ < _loc2_.length)
            {
               if((_loc2_[_loc4_] as TattooHole).oldAddProperty > -1)
               {
                  _effect["effect" + (_loc4_ + 1)].visible = true;
               }
            }
            _loc4_++;
         }
         updateTips();
         setImprintState();
      }
      
      private function setImprintState() : void
      {
         var _loc7_:int = 0;
         var _loc1_:Array = null;
         var _loc3_:TaskTemplate = null;
         var _loc6_:UpgradeTemplateInfo = null;
         var _loc8_:UpgradeTemplateInfo = null;
         var _loc4_:String = null;
         var _loc2_:String = "";
         var _loc5_:String = "";
         if(_isSelf)
         {
            _imprintImage.visible = false;
            _loc1_ = model.holeInfoIIs;
            if(TaskManage.instance.IsTaskFinish(TaskManage.ROYAL_THRONE_TASK))
            {
               _imprintBtn.visible = true;
               _imprintBtn.enable = true;
               _lockImage.visible = false;
            }
            else
            {
               _imprintBtn.visible = false;
               _imprintBtn.enable = false;
               _lockImage.visible = true;
            }
            _loc3_ = TempleteManager.instance.taskTemplateDic[TaskManage.ROYAL_THRONE_TASK];
            if(_loc3_)
            {
               _lockImage.tipData = LanguageMgr.GetTranslation("TattooView.lockImage.tipData",_loc3_.Title);
            }
         }
         else
         {
            _loc1_ = _thaneInfo.tattooPrintHoles;
            _imprintImage.visible = true;
            _imprintBtn.visible = false;
            _lockImage.visible = false;
         }
         _loc7_ = int(model.getHasImprintCount(_loc1_));
         if(_loc7_ > 0)
         {
            for each(var _loc9_:TattooHoleInfoII in _loc1_)
            {
               _loc6_ = TempleteManager.instance.getTemplateByLevelAndType(_loc9_.level,119);
               _loc8_ = TempleteManager.instance.getTemplateByLevelAndType(_loc9_.level + 1,119);
               if(_loc6_)
               {
                  _loc4_ = LanguageMgr.GetTranslation("public.level2",_loc9_.level);
                  if(!_loc8_)
                  {
                     _loc4_ = LanguageMgr.GetTranslation("public.level2","max");
                  }
                  if(_loc6_.Data > 0)
                  {
                     _loc2_ += LanguageMgr.GetTranslation("TattooView.imprintBtn.ProperityLevel" + _loc9_.property,_loc4_) + "\n";
                     _loc5_ += LanguageMgr.GetTranslation("TattooView.imprintBtn.ProperityPrecent" + _loc9_.property,_loc6_.Data) + "\n";
                  }
               }
            }
            if(_isSelf)
            {
               _imprintBtn.tipData = _loc2_ + _loc5_;
            }
            else
            {
               _imprintImage.tipData = _loc2_ + _loc5_;
            }
         }
         else if(_isSelf)
         {
            _imprintBtn.tipData = LanguageMgr.GetTranslation("TattooView.imprintBtn.noImprint.tipData");
         }
         else
         {
            _imprintImage.tipData = LanguageMgr.GetTranslation("TattooView.imprintBtn.noImprint.tipData2");
         }
      }
      
      private function updateTips() : void
      {
         var _loc4_:int = 0;
         var _loc9_:TattooHole = null;
         var _loc18_:int = 0;
         var _loc10_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc11_:int = 0;
         _tattooIcon.tipStyle = "yishi.view.tips.OneLineTip";
         _tattooIcon.isFollowMouse = false;
         _tattooIcon.tipDirctions = "7,5,4,6";
         var _loc7_:int = 0;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:Array = FrameControllerManager.instance.tattooController.tattooModel.holes;
         if(!_isSelf)
         {
            _loc2_ = _thaneInfo.holes;
         }
         if(!_loc2_)
         {
            _loc2_ = [];
            _tattooIcon.tipData = LanguageMgr.GetTranslation("tattoo.TattooView.notOpenTips");
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            switch(int((_loc9_ = _loc2_[_loc4_] as TattooHole).oldAddProperty))
            {
               case 0:
                  _loc7_ += _loc9_.oldAddingValue;
                  break;
               case 1:
                  _loc14_ += _loc9_.oldAddingValue;
                  break;
               case 2:
                  _loc8_ += _loc9_.oldAddingValue;
                  break;
               case 3:
                  _loc6_ += _loc9_.oldAddingValue;
                  break;
               case 5:
                  _loc12_ += _loc9_.oldAddingValue;
            }
            switch(int(_loc9_.oldReduceProperty))
            {
               case 0:
                  _loc7_ += _loc9_.oldReduceValue;
                  break;
               case 1:
                  _loc14_ += _loc9_.oldReduceValue;
                  break;
               case 2:
                  _loc8_ += _loc9_.oldReduceValue;
                  break;
               case 3:
                  _loc6_ += _loc9_.oldReduceValue;
                  break;
               case 5:
                  _loc12_ += _loc9_.oldReduceValue;
            }
            _loc4_++;
         }
         var _loc13_:Array = _isSelf ? model.holeInfoIIs : _thaneInfo.tattooPrintHoles;
         var _loc15_:String = "";
         if(model.getImprintTotalCountByProperity(0,_loc13_) > 0)
         {
            _loc18_ = model.getImprintTotalCountByProperity(0,_loc13_) * _loc7_ / 100;
            if(_loc7_ > 0)
            {
               _loc15_ = "<font color=\'#59cd41\'>+" + _loc18_ + "</font>";
            }
            else
            {
               _loc15_ = "<font color=\'#fa0600\'>" + _loc18_ + "</font>";
            }
         }
         var _loc16_:String = "";
         if(model.getImprintTotalCountByProperity(1,_loc13_) > 0)
         {
            _loc10_ = model.getImprintTotalCountByProperity(1,_loc13_) * _loc14_ / 100;
            if(_loc14_ > 0)
            {
               _loc16_ = "<font color=\'#59cd41\'>+" + _loc10_ + "</font>";
            }
            else
            {
               _loc16_ = "<font color=\'#fa0600\'>" + _loc10_ + "</font>";
            }
         }
         var _loc1_:String = "";
         if(model.getImprintTotalCountByProperity(2,_loc13_) > 0)
         {
            _loc19_ = model.getImprintTotalCountByProperity(2,_loc13_) * _loc8_ / 100;
            if(_loc8_ > 0)
            {
               _loc1_ = "<font color=\'#59cd41\'>+" + _loc19_ + "</font>";
            }
            else
            {
               _loc1_ = "<font color=\'#fa0600\'>" + _loc19_ + "</font>";
            }
         }
         var _loc5_:String = "";
         if(model.getImprintTotalCountByProperity(3,_loc13_) > 0)
         {
            _loc20_ = model.getImprintTotalCountByProperity(3,_loc13_) * _loc6_ / 100;
            if(_loc6_ > 0)
            {
               _loc5_ = "<font color=\'#59cd41\'>+" + _loc20_ + "</font>";
            }
            else
            {
               _loc5_ = "<font color=\'#fa0600\'>" + _loc20_ + "</font>";
            }
         }
         var _loc3_:String = "";
         if(model.getImprintTotalCountByProperity(5,_loc13_) > 0)
         {
            _loc11_ = model.getImprintTotalCountByProperity(5,_loc13_) * _loc12_ / 100;
            if(_loc12_ > 0)
            {
               _loc3_ = "<font color=\'#59cd41\'>+" + _loc11_ + "</font>";
            }
            else
            {
               _loc3_ = "<font color=\'#fa0600\'>" + _loc11_ + "</font>";
            }
         }
         var _loc17_:String = LanguageMgr.GetTranslation("tattoo.TattooView.tips") + "\n";
         if(_loc7_ >= 0)
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName0") + "+" + _loc7_ + "  " + _loc15_ + "\n";
         }
         else
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName0") + _loc7_ + "  " + _loc15_ + "\n";
         }
         if(_loc14_ >= 0)
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName1") + "+" + _loc14_ + "  " + _loc16_ + "\n";
         }
         else
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName1") + _loc14_ + "  " + _loc16_ + "\n";
         }
         if(_loc8_ >= 0)
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName2") + "+" + _loc8_ + "  " + _loc1_ + "\n";
         }
         else
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName2") + _loc8_ + "  " + _loc1_ + "\n";
         }
         if(_loc6_ >= 0)
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName3") + "+" + _loc6_ + "  " + _loc5_ + "\n";
         }
         else
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName3") + _loc6_ + "  " + _loc5_ + "\n";
         }
         if(_loc12_ >= 0)
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName5") + "+" + _loc12_ + "  " + _loc3_ + "\n";
         }
         else
         {
            _loc17_ += LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName5") + _loc12_ + "  " + _loc3_ + "\n";
         }
         _tattooIcon.tipData = _loc17_;
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("TATTOO_INFO",this,updateTattooInfo);
         _helpBtn.addEventListener("click",__onHelpClick);
         _imprintBtn.addEventListener("click",__imprintClickHandler);
         MsgMan.addObserver("TATTOO_NEWHOLE_INFO",this,updateTattooInfo);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("TATTOO_INFO",this,updateTattooInfo);
         _helpBtn.removeEventListener("click",__onHelpClick);
         _imprintBtn.removeEventListener("click",__imprintClickHandler);
         MsgMan.removeObserver("TATTOO_NEWHOLE_INFO",this,updateTattooInfo);
      }
      
      private function updateTattooInfo(param1:String, param2:Object) : void
      {
         refresh();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : TattooModel
      {
         return FrameControllerManager.instance.tattooController.tattooModel;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         FrameControllerManager.instance.tattooController.tattooModel.missionType = 0;
         removeEvent();
         _filter = null;
         ObjectUtils.disposeObject(_mainBack);
         _mainBack = null;
         ObjectUtils.disposeObject(_mainBg);
         _mainBg = null;
         ObjectUtils.disposeObject(_tattooIcon);
         _tattooIcon = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         ObjectUtils.disposeObject(_imprintBtn);
         _imprintBtn = null;
         _loc1_ = 0;
         while(_loc1_ < holes.length)
         {
            holes[_loc1_].removeEventListener("click",holeClickHandle);
            holes[_loc1_].removeEventListener("mouseOver",holeOverHandle);
            holes[_loc1_].removeEventListener("mouseOut",holeOutHandle);
            ObjectUtils.disposeObject(holes[_loc1_] as TattooHoleView);
            holes[_loc1_] = null;
            _loc1_++;
         }
         holes = null;
      }
   }
}

