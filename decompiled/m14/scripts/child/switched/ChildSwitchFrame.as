package child.switched
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildSwitchFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var selectChildBtn:BaseButton;
      
      private var contentText:FilterFrameText;
      
      private var confirmBtn:SelectedCheckButton;
      
      private var cancelBtn:SelectedCheckButton;
      
      private var leftChildIcon:BaseIconView;
      
      private var rightChildIcon:BaseIconView;
      
      private var selectChildView:ChildSwitchSelectView;
      
      private var costPoint:int;
      
      private var _data:ChildData;
      
      private var _rightData:ChildData;
      
      public function ChildSwitchFrame()
      {
         super();
         costPoint = ConfigInfoManager.instance.getChildTransPoint();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchFrame.back");
         selectChildBtn = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchFrame.selectChildBtn");
         contentText = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchFrame.contentText");
         confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchFrame.confirmBtn");
         cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchFrame.cancelBtn");
         leftChildIcon = ComponentFactory.Instance.creatCustomObject("ChildSwitchFrame.leftChildIcon");
         rightChildIcon = ComponentFactory.Instance.creatCustomObject("ChildSwitchFrame.rightChildIcon");
         addToContent(back);
         addToContent(selectChildBtn);
         addToContent(contentText);
         addToContent(confirmBtn);
         addToContent(cancelBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         confirmBtn.addEventListener("click",__confirmBtnHandler);
         cancelBtn.addEventListener("click",__cancelBtnBtnHandler);
         selectChildBtn.addEventListener("click",__selectChildHandler);
         rightChildIcon.addEventListener("click",__selectChildHandler);
         MsgMan.addObserver("ChildEvent.CHILD_SWITCH_SELECT",this,__selectSwitchChildHandle);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(confirmBtn)
         {
            confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
         if(cancelBtn)
         {
            cancelBtn.removeEventListener("click",__cancelBtnBtnHandler);
         }
         if(selectChildBtn)
         {
            selectChildBtn.removeEventListener("click",__selectChildHandler);
         }
         if(rightChildIcon)
         {
            rightChildIcon.removeEventListener("click",__selectChildHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_SWITCH_SELECT",this,__selectSwitchChildHandle);
      }
      
      private function __selectSwitchChildHandle(param1:String, param2:Object) : void
      {
         var _loc3_:ChildData = param2 as ChildData;
         if(_loc3_)
         {
            selectRightChild(_loc3_);
         }
      }
      
      private function __selectChildHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(model.getSwitchChildListByChildId(_data,_rightData).length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.ChildSwitchFrame.noChildCanSelect"));
            return;
         }
         if(!selectChildView)
         {
            selectChildView = new ChildSwitchSelectView();
            selectChildView.show(model.getSwitchChildListByChildId(_data,_rightData));
            selectChildView.addEventListener("dispose",__disposeSelectView);
            _loc2_ = new Point(selectChildBtn.displayWidth / 2,0);
            _loc2_ = selectChildBtn.localToGlobal(_loc2_);
            selectChildView.x = _loc2_.x + 45;
            selectChildView.y = _loc2_.y - 5;
         }
      }
      
      private function __disposeSelectView(param1:Event) : void
      {
         selectChildView.removeEventListener("dispose",__disposeSelectView);
         selectChildView = null;
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         if(!_rightData)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.ChildSwitchFrame.noSelectChild"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < costPoint)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc5_:String = LanguageMgr.GetTranslation("ChildSwitchFrame.confirmBtnHandler.tipTxt",costPoint);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [sendToServer];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
      }
      
      private function sendToServer(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         ChildSender.switchChild(_data.childId,_rightData.childId);
         dispose();
      }
      
      private function __cancelBtnBtnHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         clean();
         if(!_data)
         {
            return;
         }
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
         if(_loc2_)
         {
            leftChildIcon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            leftChildIcon.tipData = _data;
            addToContent(leftChildIcon);
         }
         contentText.htmlText = LanguageMgr.GetTranslation("ChildSwitchFrame.contentText.text",costPoint);
      }
      
      public function selectRightChild(param1:ChildData) : void
      {
         _rightData = param1;
         if(rightChildIcon && rightChildIcon.parent)
         {
            rightChildIcon.parent.removeChild(rightChildIcon);
         }
         if(!_rightData)
         {
            return;
         }
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_rightData.job,_rightData.growthGrade);
         if(_loc2_)
         {
            rightChildIcon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            addToContent(rightChildIcon);
            rightChildIcon.tipData = _rightData;
            rightChildIcon.buttonMode = true;
         }
      }
      
      private function clean() : void
      {
         if(leftChildIcon && leftChildIcon.parent)
         {
            leftChildIcon.parent.removeChild(leftChildIcon);
         }
         contentText.text = "";
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("ChildSwitchFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(selectChildBtn);
         selectChildBtn = null;
         ObjectUtils.disposeObject(contentText);
         contentText = null;
         ObjectUtils.disposeObject(confirmBtn);
         confirmBtn = null;
         ObjectUtils.disposeObject(cancelBtn);
         cancelBtn = null;
         ObjectUtils.disposeObject(leftChildIcon);
         leftChildIcon = null;
         ObjectUtils.disposeObject(rightChildIcon);
         rightChildIcon = null;
         ObjectUtils.disposeObject(selectChildView);
         selectChildView = null;
         super.dispose();
      }
   }
}

