package consortia.view.myConsortia.chairmanElection
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import events.ConsortiaEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.ConsortiaManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ElectionFrame extends Frame
   {
      
      private var _listView:ElectionListView;
      
      private var _voteView:ElectionVoteView;
      
      private var _noteTxt:FilterFrameText;
      
      private var _helper:SimpleBitmapButton;
      
      private var _model:ConsortiaModel;
      
      private var helper:ElectionHelperView;
      
      public function ElectionFrame()
      {
         super();
         _model = ConsortiaManager.instance.model;
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _listView = ComponentFactory.Instance.creatCustomObject("consortia.ElectionListView");
         _voteView = ComponentFactory.Instance.creatCustomObject("consortia.ElectionVoteView");
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionNote");
         _helper = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionHelperBtn");
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.ElectionFrameTitle");
         setNoteText();
         _voteView.voteBtn.enable = false;
         addToContent(_listView);
         addToContent(_voteView);
         addToContent(_noteTxt);
         addToContent(_helper);
      }
      
      private function setNoteText() : void
      {
         var _loc2_:Date = _model.consortiaInfo.votingDate;
         var _loc1_:Date = new Date(_loc2_.fullYear,_loc2_.month,_loc2_.date,_loc2_.hours);
         _loc1_["date"] += 14;
         if(_loc1_.fullYear == _loc2_.fullYear)
         {
            _noteTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.note",_loc1_.month + 1,_loc1_.date,_loc1_.hours);
         }
         else
         {
            _noteTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.note",_loc1_.fullYear + "-" + (_loc1_.month + 1),_loc1_.date,_loc1_.hours);
         }
         _loc2_ = null;
         _loc1_ = null;
      }
      
      protected function addEvent() : void
      {
         _voteView.voteBtn.addEventListener("click",__sendVoteInfo);
         _model.addEventListener("CONSORTIA_VOTINGLIST_CHANGE",__setListView);
         _helper.addEventListener("click",__onShowHelpView);
         addEventListener("response",__frameResponse);
      }
      
      protected function removeEvent() : void
      {
         _voteView.voteBtn.removeEventListener("click",__sendVoteInfo);
         _model.removeEventListener("CONSORTIA_VOTINGLIST_CHANGE",__setListView);
         _helper.removeEventListener("click",__onShowHelpView);
         removeEventListener("response",__frameResponse);
      }
      
      private function __sendVoteInfo(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_listView.selecedValue)
         {
            _voteView.voteBtn.enable = false;
            ConsortiaSocektSendManager.sendVotingInfo(_listView.selecedValue);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.tip01"));
         }
      }
      
      private function __setListView(param1:ConsortiaEvent) : void
      {
         _listView.dataProvider = _model.votingUsers;
         var _loc2_:Boolean = true;
         if(_listView.dataProvider.length == 0 || _model.hasVotePermission == false || _model.hasVoted == true)
         {
            _loc2_ = false;
         }
         _listView.enable = _loc2_;
         _voteView.voteBtn.enable = _loc2_;
      }
      
      private function __onShowHelpView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         helper = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionHelperView");
         helper.show();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         _listView = null;
         _voteView = null;
         _noteTxt = null;
         _helper = null;
         helper && helper.dispose();
         helper = null;
         super.dispose();
      }
   }
}

