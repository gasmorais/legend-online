package dragontitan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.StarBar;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTitanDevelopView extends Component
   {
      
      private var _arrow:Image;
      
      private var _experienceImgTxt:Image;
      
      private var _developBtn:IconButton;
      
      private var _inputBox:Image;
      
      private var _progress:ProgressView;
      
      private var _starBar:StarBar;
      
      private var _currentLvl:FilterFrameText;
      
      private var _nextLvl:FilterFrameText;
      
      private var _currentProperty:FilterFrameText;
      
      private var _nextProperty:FilterFrameText;
      
      private var _costStones:FilterFrameText;
      
      private var _costStonesNum:FilterFrameText;
      
      private var _currentStones:FilterFrameText;
      
      private var _currentStonesNum:FilterFrameText;
      
      public function DragonTitanDevelopView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _arrow = ComponentFactory.Instance.creatComponentByStylename("dragontitan.arrow");
         _experienceImgTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.experienceImgTxt");
         _developBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.developBtn");
         _inputBox = ComponentFactory.Instance.creatComponentByStylename("dragontitan.inputBox");
         _currentLvl = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.currentLvl");
         _nextLvl = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.nextLvl");
         _currentProperty = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.currentProperty");
         _nextProperty = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.nextProperty");
         _costStones = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.costStones");
         _costStonesNum = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.costStonesNum");
         _currentStones = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.currentStones");
         _currentStonesNum = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.currentStonesNum");
         _progress = new ProgressView();
         _progress.x = 359;
         _progress.y = 262;
         var _loc1_:int = int(model.getTitanIdMaxStar());
         var _loc4_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(model.starLevel + 1,116);
         if(_loc4_ && _loc4_.Data > 0)
         {
            _progress.creatMask(model.starExp,_loc4_.Data);
         }
         _starBar = new StarBar(9,model.getStars(),"asset.dragontitan.emptyStar","asset.dragontitan.fullStar");
         _starBar.x = 338;
         _starBar.y = 228;
         _costStones.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.costStones");
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(208054));
         var _loc2_:int = int(_loc3_ > 0 ? _loc3_ : 1);
         _loc2_ = int(_loc2_ > 9999 ? 9999 : _loc2_);
         _costStonesNum.text = _loc2_ + "";
         _currentStones.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.currentStones");
         refreshView();
         addChild(_arrow);
         addChild(_experienceImgTxt);
         addChild(_developBtn);
         addChild(_inputBox);
         addChild(_progress);
         addChild(_starBar);
         addChild(_currentLvl);
         addChild(_nextLvl);
         addChild(_currentProperty);
         addChild(_nextProperty);
         addChild(_costStones);
         addChild(_costStonesNum);
         addChild(_currentStones);
         addChild(_currentStonesNum);
      }
      
      private function unInitView() : void
      {
         if(_arrow)
         {
            ObjectUtils.disposeObject(_arrow);
         }
         _arrow = null;
         if(_experienceImgTxt)
         {
            ObjectUtils.disposeObject(_experienceImgTxt);
         }
         _experienceImgTxt = null;
         if(_inputBox)
         {
            ObjectUtils.disposeObject(_inputBox);
         }
         _inputBox = null;
         if(_progress)
         {
            ObjectUtils.disposeObject(_progress);
         }
         _progress = null;
         if(_currentLvl)
         {
            ObjectUtils.disposeObject(_currentLvl);
         }
         _currentLvl = null;
         if(_nextLvl)
         {
            ObjectUtils.disposeObject(_nextLvl);
         }
         _nextLvl = null;
         if(_currentProperty)
         {
            ObjectUtils.disposeObject(_currentProperty);
         }
         _currentProperty = null;
         if(_nextProperty)
         {
            ObjectUtils.disposeObject(_nextProperty);
         }
         _nextProperty = null;
         if(_costStones)
         {
            ObjectUtils.disposeObject(_costStones);
         }
         _costStones = null;
         if(_costStonesNum)
         {
            ObjectUtils.disposeObject(_costStonesNum);
         }
         _costStonesNum = null;
         if(_currentStones)
         {
            ObjectUtils.disposeObject(_currentStones);
         }
         _currentStones = null;
         if(_currentStonesNum)
         {
            ObjectUtils.disposeObject(_currentStonesNum);
         }
         _currentStonesNum = null;
      }
      
      private function initEvent() : void
      {
         if(_developBtn)
         {
            _developBtn.addEventListener("click",__developBtnHandler);
         }
         MsgMan.addObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
         _costStonesNum.addEventListener("change",__textChangHandler);
         _costStonesNum.addEventListener("focusIn",__inHandler);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_costStonesNum.text);
         if(_loc2_ <= 0)
         {
            _costStonesNum.text = "1";
         }
         if(_loc2_ > 9999)
         {
            _costStonesNum.text = "9999";
         }
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _costStonesNum.setSelection(0,_costStonesNum.text.length);
      }
      
      private function refreshView(param1:String = null, param2:Object = null) : void
      {
         var _loc3_:int = int(model.getTitanIdMaxStar());
         var _loc6_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(model.starLevel + 1,116);
         if(_loc6_ && _loc6_.Data > 0 && model.starLevel + 1 < _loc3_)
         {
            _progress.visible = true;
            _progress.creatMask(model.starExp,_loc6_.Data);
            _nextLvl.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.nextLvl") + LanguageMgr.GetTranslation("DragonTitanFrame.starLevels",model.getSteps(),model.getStars() + 1);
            _nextProperty.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.addProperty",model.starLevel * 100 + 100);
            _starBar.visible = true;
            _starBar.progress = model.getStars();
            _experienceImgTxt.visible = true;
            _nextProperty.y = 79;
         }
         else
         {
            _progress.visible = false;
            _starBar.visible = false;
            _experienceImgTxt.visible = false;
            _nextLvl.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.alreadyMaxLvl");
            _nextProperty.text = LanguageMgr.GetTranslation("army.stone.fullLV");
            _nextProperty.y = 134;
         }
         _currentLvl.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.currentLvl") + LanguageMgr.GetTranslation("DragonTitanFrame.starLevels",model.getSteps(),model.getStars());
         _currentProperty.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.addProperty",model.starLevel * 100);
         var _loc5_:int = int(GoodsManager.instance.getGoodsNumByTempId(208054));
         _currentStonesNum.text = _loc5_ + "";
         var _loc4_:int = int(_loc5_ > 0 ? _loc5_ : 1);
         _loc4_ = int(_loc4_ > 9999 ? 9999 : _loc4_);
         _costStonesNum.text = _loc4_ + "";
         _currentStonesNum.x = _currentStones.x + _currentStones.textWidth + 4;
      }
      
      private function removeEvent() : void
      {
         if(_developBtn)
         {
            _developBtn.removeEventListener("click",__developBtnHandler);
         }
         MsgMan.removeObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
      }
      
      protected function __switchBtnHandler(param1:MouseEvent) : void
      {
      }
      
      private function __developBtnHandler(param1:MouseEvent) : void
      {
         var _loc6_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(model.starLevel + 1,116);
         if(!_loc6_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTitanDevelopView.alreadyMaxLvl"));
            return;
         }
         var _loc5_:int = 1;
         try
         {
            _loc5_ = parseInt(_costStonesNum.text);
         }
         catch(e:Error)
         {
            _loc5_ = 1;
            _costStonesNum.text = "1";
         }
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("titan_upgrade_point");
         var _loc4_:int = _loc2_ ? parseInt(_loc2_.ConfigValue) : 10;
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc7_:String = LanguageMgr.GetTranslation("DragonTitanDevelopView.cost",_loc5_,_loc5_ * _loc4_);
         SharedManagerHelper.ins.needAlert("DragonTitanDevelopView.__developBtnHandler",sendDevelop,_loc3_,_loc7_,"");
      }
      
      private function sendDevelop(param1:Boolean) : void
      {
         var _loc2_:int = 1;
         try
         {
            _loc2_ = parseInt(_costStonesNum.text);
         }
         catch(e:Error)
         {
            MessageTipManager.instance().show("DragonTitanDevelopView.developCountError");
            return;
         }
         DragonTitanManager.instance.sendDevelop(param1 ? 2 : 1,_loc2_);
         refreshView();
      }
      
      private function get model() : DragonTitanModel
      {
         return DragonTitanManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

