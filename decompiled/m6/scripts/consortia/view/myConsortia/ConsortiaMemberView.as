package consortia.view.myConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaMemberView extends Component
   {
      
      private var _memberBg:Bitmap;
      
      private var _memberBtn:BaseButton;
      
      private var _dutyBtn:BaseButton;
      
      private var _jobBtn:BaseButton;
      
      private var _levelBtn:BaseButton;
      
      private var _contributeBtn:BaseButton;
      
      private var _apBtn:BaseButton;
      
      private var _offlineTimeBtn:BaseButton;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _memberList:ConsortiaMemberList;
      
      private var _data:ConsortiaModel;
      
      private var _lastSort:String = "grades";
      
      private var _isDes:Boolean = true;
      
      public function ConsortiaMemberView()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.consortiaController.model;
         _memberBg = ComponentFactory.Instance.creatBitmap("asset.consortia.consortiaStaffListBG");
         _memberBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaMemberButton");
         _dutyBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaDutyButton");
         _jobBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaJobButton");
         _levelBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaLevelButton");
         _contributeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaContributeButton");
         _apBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaAPButton");
         _offlineTimeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaOffLineButton");
         _memberList = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaMemberList");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.ScrollPanel");
         addChild(_memberBg);
         addChild(_memberBtn);
         addChild(_dutyBtn);
         addChild(_jobBtn);
         addChild(_levelBtn);
         addChild(_contributeBtn);
         addChild(_apBtn);
         addChild(_offlineTimeBtn);
         addChild(_memberList);
         _scrollPanel.setView(_memberList);
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
      }
      
      private function initData() : void
      {
         ConsortiaManager.instance.getConsortiaUserInfos();
      }
      
      private function addEvent() : void
      {
         _memberList.addEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
         _memberBtn.addEventListener("click",__sortOnHandler);
         _dutyBtn.addEventListener("click",__sortOnHandler);
         _jobBtn.addEventListener("click",__sortOnHandler);
         _levelBtn.addEventListener("click",__sortOnHandler);
         _contributeBtn.addEventListener("click",__sortOnHandler);
         _apBtn.addEventListener("click",__sortOnHandler);
         _offlineTimeBtn.addEventListener("click",__sortOnHandler);
      }
      
      private function removeEvent() : void
      {
         _memberList.removeEventListener("UPDATA_CONSORTIA_MEMBER",__onMemberListUpdata);
         _memberBtn.removeEventListener("click",__sortOnHandler);
         _dutyBtn.removeEventListener("click",__sortOnHandler);
         _jobBtn.removeEventListener("click",__sortOnHandler);
         _levelBtn.removeEventListener("click",__sortOnHandler);
         _contributeBtn.removeEventListener("click",__sortOnHandler);
         _apBtn.removeEventListener("click",__sortOnHandler);
         _offlineTimeBtn.removeEventListener("click",__sortOnHandler);
      }
      
      private function __sortOnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _memberList.isFirst = false;
         if(param1.currentTarget == _memberBtn)
         {
            _lastSort = "nickName";
         }
         else if(param1.currentTarget == _dutyBtn)
         {
            _lastSort = "dutyId";
         }
         else if(param1.currentTarget == _jobBtn)
         {
            _lastSort = "job";
         }
         else if(param1.currentTarget == _levelBtn)
         {
            _lastSort = "grades";
         }
         else if(param1.currentTarget == _contributeBtn)
         {
            _lastSort = "consortiaTotalOffer";
         }
         else if(param1.currentTarget == _apBtn)
         {
            _lastSort = "fightingCapacity";
         }
         else if(param1.currentTarget == _offlineTimeBtn)
         {
            _lastSort = "LogOutTimeMs";
         }
         _memberList.refreshMemberList(_lastSort,_isDes);
         _isDes = _isDes ? false : true;
      }
      
      private function __onMemberListUpdata(param1:ConsortiaEvent) : void
      {
         _scrollPanel.invalidateViewport();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_memberBtn);
         _memberBtn = null;
         ObjectUtils.disposeObject(_dutyBtn);
         _dutyBtn = null;
         ObjectUtils.disposeObject(_levelBtn);
         _levelBtn = null;
         ObjectUtils.disposeObject(_contributeBtn);
         _contributeBtn = null;
         ObjectUtils.disposeObject(_apBtn);
         _apBtn = null;
         ObjectUtils.disposeObject(_offlineTimeBtn);
         _offlineTimeBtn = null;
         ObjectUtils.disposeObject(_memberBg);
         _memberBg = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeAllChildren(this);
         _memberList = null;
         super.dispose();
      }
   }
}

