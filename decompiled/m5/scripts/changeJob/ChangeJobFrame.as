package changeJob
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ChangeJobFrame extends Frame
   {
      
      private var _frameBack:Scale9CornerImage;
      
      private var _bg:Image;
      
      private var _bgTitle:Bitmap;
      
      private var _leftPromptTxt:FilterFrameText;
      
      private var _leftPropertyRequireTxt:FilterFrameText;
      
      private var _leftBg:Image;
      
      private var _frameTitleImage:Image;
      
      private var _leftJobIcon:ScaleFrameImage;
      
      private var _leftJobTxtImg:ScaleFrameImage;
      
      private var _leftContainer:Component;
      
      private var _filter:IFilterFormat;
      
      private var _conformBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      public function ChangeJobFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _frameBack = ComponentFactory.Instance.creatComponentByStylename("changeJob.toChooseFrameBack");
         _bg = ComponentFactory.Instance.creatComponentByStylename("changeJob.toChooseTxt");
         _bgTitle = ComponentFactory.Instance.creatBitmap("asset.army.skillChangeJobBgTitle");
         _leftPromptTxt = ComponentFactory.Instance.creatComponentByStylename("changeJob.leftPromptTxt");
         _leftPropertyRequireTxt = ComponentFactory.Instance.creatComponentByStylename("changeJob.leftPropertyRequireTxt");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("changeJob.leftBg");
         _frameTitleImage = ComponentFactory.Instance.creatComponentByStylename("core.FrameTitleImage2");
         _leftJobIcon = ComponentFactory.Instance.creatComponentByStylename("ui.army.change.jobIcons");
         _leftJobTxtImg = ComponentFactory.Instance.creatComponentByStylename("ui.army.change.jobTxt");
         _conformBtn = ComponentFactory.Instance.creatComponentByStylename("changeJob.conformBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("changeJob.cancelBtn");
         _frameTitleImage.alpha = 0.6;
         _frameTitleImage.x = -30;
         _frameTitleImage.y = -20;
         _frameTitleImage.width = 437;
         _frameTitleImage.height = 17;
         _leftContainer = new Component();
         _leftContainer.x = 94;
         _leftContainer.y = 13;
         _leftPromptTxt.text = LanguageMgr.GetTranslation("changeJob.needTattooProperty");
         var _loc1_:int = int(ArmyManager.instance.thane.templateInfo.Job);
         setConditionString(_loc1_,1,_leftPropertyRequireTxt);
         _leftJobIcon.setFrame(_loc1_);
         _leftJobTxtImg.setFrame(_loc1_);
         addToContent(_frameBack);
         addToContent(_bg);
         addToContent(_bgTitle);
         addToContent(_leftContainer);
         addToContent(_frameTitleImage);
         addToContent(_conformBtn);
         addToContent(_cancelBtn);
         _leftContainer.addChild(_leftBg);
         _leftContainer.addChild(_leftPromptTxt);
         _leftContainer.addChild(_leftPropertyRequireTxt);
         _leftContainer.addChild(_leftJobIcon);
         _leftContainer.addChild(_leftJobTxtImg);
      }
      
      private function setConditionString(param1:int, param2:int, param3:FilterFrameText) : void
      {
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = "Job" + param1 + "_Branch" + param2;
         var _loc10_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName(_loc12_);
         if(!_loc10_)
         {
            return;
         }
         var _loc6_:String = _loc10_.ConfigValue;
         var _loc5_:Array = _loc6_.split(",");
         var _loc9_:Array = FrameControllerManager.instance.tattooController.tattooModel.calculateAddProperty();
         var _loc4_:String = "";
         var _loc8_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc11_ = int(_loc5_[_loc7_]);
            if(_loc11_ > 0)
            {
               _loc8_++;
               _loc4_ += LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip0" + (_loc7_ + 1)) + "+" + _loc5_[_loc7_] + "\n";
            }
            _loc7_++;
         }
         if(_loc8_ > 2)
         {
            param3.x += 50;
         }
         else
         {
            _loc4_ = _loc4_.replace("   ","\n");
            param3.x += 84;
         }
         param3.text = _loc4_;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function addEvent() : void
      {
         thane.addEventListener("VOCATION_INDEX",__updateVocationIndexHandler);
         addEventListener("response",frameResponse);
         _conformBtn.addEventListener("click",_leftContainerClickHandle);
         _cancelBtn.addEventListener("click",cancelCickHandler);
      }
      
      protected function __updateVocationIndexHandler(param1:Event) : void
      {
         if(thane.vocationIndex > 0)
         {
            dispose();
         }
      }
      
      private function _leftContainerOutHandle(param1:MouseEvent) : void
      {
         Mouse.cursor = "auto";
         _filter.setNormalFilter(_leftContainer);
      }
      
      private function _leftContainerOverHandle(param1:MouseEvent) : void
      {
         Mouse.cursor = "button";
         _filter.setLightingFilter(_leftContainer);
      }
      
      private function _leftContainerClickHandle(param1:MouseEvent) : void
      {
         if(!checkBranchCondition(thane.templateInfo.Job,1))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("changeJob.changeBranchFail"));
            return;
         }
         FrameControllerManager.instance.changeJobControler.sendChooseBranch(1);
      }
      
      private function checkBranchCondition(param1:int, param2:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc10_:String = "Job" + param1 + "_Branch" + param2;
         var _loc9_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName(_loc10_);
         if(!_loc9_)
         {
            return false;
         }
         var _loc6_:String = _loc9_.ConfigValue;
         var _loc5_:Array = _loc6_.split(",");
         var _loc8_:Array = FrameControllerManager.instance.tattooController.tattooModel.calculateAddProperty();
         var _loc3_:String = "";
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc4_ = int(_loc5_[_loc7_]);
            if(_loc4_ > 0)
            {
               if(_loc8_[_loc7_] < _loc4_)
               {
                  return false;
               }
            }
            _loc7_++;
         }
         return true;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function removeEvent() : void
      {
         thane.removeEventListener("VOCATION_INDEX",__updateVocationIndexHandler);
         removeEventListener("response",frameResponse);
         _conformBtn.removeEventListener("click",_leftContainerClickHandle);
         _cancelBtn.removeEventListener("click",cancelCickHandler);
      }
      
      private function cancelCickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_frameBack);
         _frameBack = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bgTitle);
         _bgTitle = null;
         ObjectUtils.disposeObject(_leftPromptTxt);
         _leftPromptTxt = null;
         ObjectUtils.disposeObject(_leftPropertyRequireTxt);
         _leftPropertyRequireTxt = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_frameTitleImage);
         _frameTitleImage = null;
         ObjectUtils.disposeObject(_leftJobIcon);
         _leftJobIcon = null;
         ObjectUtils.disposeObject(_leftJobTxtImg);
         _leftJobTxtImg = null;
         ObjectUtils.disposeObject(_leftContainer);
         _leftContainer = null;
         ObjectUtils.disposeObject(_conformBtn);
         _conformBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         _filter = null;
         super.dispose();
      }
   }
}

