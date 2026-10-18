package petchallenge
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.ModuleFrameInfo;
   import mvc.controler.PetChallengeController;
   import mvc.module.petchallenge.PetChallengeModel;
   import petchallenge.views.PetChallengeInfoView;
   import petchallenge.views.PetChallengeListView;
   import petchallenge.views.PetChallengeTeamView;
   import yishi.manager.FrameControllerManager;
   
   public class PetChallengeFrame extends Frame
   {
      
      private var backBorder:Scale9CornerImage;
      
      private var sortBtn:SelectedIconButton;
      
      private var challengeBtn:SelectedIconButton;
      
      private var reportBtn:SelectedIconButton;
      
      private var btnHbox:HBox;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var back:Bitmap;
      
      private var _listView:PetChallengeListView;
      
      private var _infoView:PetChallengeInfoView;
      
      private var _teamView:PetChallengeTeamView;
      
      public function PetChallengeFrame()
      {
         super();
         initView();
         addEvent();
         model.loadSortData();
         btnGroup.selectIndex = 1;
         PetChallengeManager.instance.requestChallengeData();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         backBorder = ComponentFactory.Instance.creatComponentByStylename("petchallenge.BackBorder");
         back = ComponentFactory.Instance.creatBitmap("asset.PetChallengeFrame.back");
         sortBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeFrame.sortBtn");
         challengeBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeFrame.challengeBtn");
         reportBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeFrame.reportBtn");
         btnHbox = ComponentFactory.Instance.creatComponentByStylename("PetChallengeFrame.btnHbox");
         _listView = ComponentFactory.Instance.creatCustomObject("PetChallengeFrame.listView");
         _infoView = ComponentFactory.Instance.creatCustomObject("PetChallengeFrame.infoView");
         _teamView = ComponentFactory.Instance.creatCustomObject("PetChallengeFrame.teamView");
         btnGroup = new SelectedButtonGroup();
         btnHbox.addChild(sortBtn);
         btnHbox.addChild(challengeBtn);
         btnHbox.addChild(reportBtn);
         btnGroup.addSelectItem(sortBtn);
         btnGroup.addSelectItem(challengeBtn);
         btnGroup.addSelectItem(reportBtn);
         addToContent(backBorder);
         addToContent(btnHbox);
         addToContent(back);
         addToContent(_listView);
         addToContent(_infoView);
         addToContent(_teamView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(btnGroup)
         {
            btnGroup.addEventListener("change",__tabChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(btnGroup)
         {
            btnGroup.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         model.curSelectIndex = btnGroup.selectIndex;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         titleText = LanguageMgr.GetTranslation("PetChallengeFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      private function get control() : PetChallengeController
      {
         return FrameControllerManager.instance.petchallengeController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(backBorder);
         backBorder = null;
         ObjectUtils.disposeObject(sortBtn);
         sortBtn = null;
         ObjectUtils.disposeObject(challengeBtn);
         challengeBtn = null;
         ObjectUtils.disposeObject(reportBtn);
         reportBtn = null;
         ObjectUtils.disposeObject(btnHbox);
         btnHbox = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_infoView);
         _infoView = null;
         ObjectUtils.disposeObject(_teamView);
         _teamView = null;
         ObjectUtils.disposeObject(btnGroup);
         btnGroup = null;
         if(control)
         {
            control.closeChallengeFrame();
         }
         model.clearSortLoad();
         super.dispose();
      }
   }
}

