package vip
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import yishi.manager.FrameControllerManager;
   
   public class VipPrivilegeFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _privilegeImg:ScaleFrameImage;
      
      private var _privilegeTitleTxt:GradientText;
      
      private var _privilegeContentTextArea:TextArea;
      
      private var _privilegeNumList:Array = [11,13,16,20,20,20,20,20,20];
      
      private var _index:int;
      
      private var _vipBtn1:SelectedButton;
      
      private var _vipBtn2:SelectedButton;
      
      private var _vipBtn3:SelectedButton;
      
      private var _vipBtn4:SelectedButton;
      
      private var _vipBtn5:SelectedButton;
      
      private var _vipBtn6:SelectedButton;
      
      private var _vipBtn7:SelectedButton;
      
      private var _vipBtn8:SelectedButton;
      
      private var _vipBtn9:SelectedButton;
      
      public function VipPrivilegeFrame()
      {
         super();
         initView();
         initEvent();
         var _loc1_:int = int(VIPManager.Instance.model.vipInfo.VipGrade);
         index = _loc1_ > 0 ? _loc1_ : 1;
         this["_vipBtn" + _loc1_].dispatchEvent(new MouseEvent("click"));
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("vip.view.VipPrivilegeFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeFrameMultipleBg");
         _privilegeImg = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeFramePrivilegeImg");
         _privilegeTitleTxt = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeFramePrivilegeTitleGradientTxt");
         _privilegeContentTextArea = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeFramePrivilegeContentTextArea");
         _vipBtn1 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn1");
         _vipBtn2 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn2");
         _vipBtn3 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn3");
         _vipBtn4 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn4");
         _vipBtn5 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn5");
         _vipBtn6 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn6");
         _vipBtn7 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn7");
         _vipBtn8 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn8");
         _vipBtn9 = ComponentFactory.Instance.creatComponentByStylename("vip.VipPrivilegeBtn9");
         addToContent(_bg);
         addToContent(_privilegeImg);
         addToContent(_privilegeTitleTxt);
         addToContent(_privilegeContentTextArea);
         addToContent(_vipBtn9);
         addToContent(_vipBtn8);
         addToContent(_vipBtn7);
         addToContent(_vipBtn6);
         addToContent(_vipBtn5);
         addToContent(_vipBtn4);
         addToContent(_vipBtn3);
         addToContent(_vipBtn2);
         addToContent(_vipBtn1);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _vipBtn1.addEventListener("click",__vipBtnHandler);
         _vipBtn2.addEventListener("click",__vipBtnHandler);
         _vipBtn3.addEventListener("click",__vipBtnHandler);
         _vipBtn4.addEventListener("click",__vipBtnHandler);
         _vipBtn5.addEventListener("click",__vipBtnHandler);
         _vipBtn6.addEventListener("click",__vipBtnHandler);
         _vipBtn7.addEventListener("click",__vipBtnHandler);
         _vipBtn8.addEventListener("click",__vipBtnHandler);
         _vipBtn9.addEventListener("click",__vipBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _vipBtn1.removeEventListener("click",__vipBtnHandler);
         _vipBtn2.removeEventListener("click",__vipBtnHandler);
         _vipBtn3.removeEventListener("click",__vipBtnHandler);
         _vipBtn4.removeEventListener("click",__vipBtnHandler);
         _vipBtn5.removeEventListener("click",__vipBtnHandler);
         _vipBtn6.removeEventListener("click",__vipBtnHandler);
         _vipBtn7.removeEventListener("click",__vipBtnHandler);
         _vipBtn8.removeEventListener("click",__vipBtnHandler);
         _vipBtn9.removeEventListener("click",__vipBtnHandler);
      }
      
      private function __vipBtnHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SelectedButton = param1.target as SelectedButton;
         _loc2_ = 1;
         while(_loc2_ <= 9)
         {
            this["_vipBtn" + _loc2_].selected = false;
            _loc2_++;
         }
         _loc3_.selected = true;
         index = int(_loc3_.stylename.substr(_loc3_.stylename.length - 1,1));
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               FrameControllerManager.instance.vipController.hidePrivilegeFrame(true);
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index == param1)
         {
            return;
         }
         _index = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         _privilegeImg.setFrame(_index);
         _privilegeTitleTxt.text = LanguageMgr.GetTranslation("vip.VipPrivilegeFrame.privilegeTitle",_index,VipContentHelper.getnumByGrade(_index,3));
         _privilegeContentTextArea.htmlText = VipContentHelper.getContentByGrade(_index,3);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,664,461);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _privilegeNumList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_privilegeImg);
         _privilegeImg = null;
         ObjectUtils.disposeObject(_privilegeTitleTxt);
         _privilegeTitleTxt = null;
         ObjectUtils.disposeObject(_privilegeContentTextArea);
         _privilegeContentTextArea = null;
         ObjectUtils.disposeObject(_vipBtn1);
         _vipBtn1 = null;
         ObjectUtils.disposeObject(_vipBtn2);
         _vipBtn2 = null;
         ObjectUtils.disposeObject(_vipBtn3);
         _vipBtn3 = null;
         ObjectUtils.disposeObject(_vipBtn4);
         _vipBtn4 = null;
         ObjectUtils.disposeObject(_vipBtn5);
         _vipBtn5 = null;
         ObjectUtils.disposeObject(_vipBtn6);
         _vipBtn6 = null;
         ObjectUtils.disposeObject(_vipBtn7);
         _vipBtn7 = null;
         ObjectUtils.disposeObject(_vipBtn8);
         _vipBtn8 = null;
         ObjectUtils.disposeObject(_vipBtn9);
         _vipBtn9 = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

