package answer
{
   import answer.view.AnswerRankView;
   import answer.view.AnswerView;
   import answer.view.base.CDTimeView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import events.AnswerEvent;
   import mainBar.ChatBar;
   import manager.LanguageMgr;
   import mvc.module.answer.AnswerItemData;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.AnswerManager;
   
   public final class AnswerFrame extends Frame
   {
      
      private var _questionV:AnswerView;
      
      private var _rankView:AnswerRankView;
      
      private var _alert:BaseAlerFrame;
      
      private var _cdTime:CDTimeView;
      
      public function AnswerFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _questionV = new AnswerView();
         _questionV.x = -2;
         _questionV.y = 25;
         addToContent(_questionV);
         _rankView = new AnswerRankView();
         _rankView.x = 462;
         _rankView.y = 30;
         addToContent(_rankView);
         _cdTime = new CDTimeView();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         AnswerManager.Instance.model.addEventListener("UPDATE_RANK",__onUpdateRankHandler);
         AnswerManager.Instance.model.addEventListener("UPDATE_ANSWER",__onUpdateAnswerHandler);
         AnswerManager.Instance.model.addEventListener("UPDATE_STATE",__onUpdateStateHandler);
         AnswerManager.Instance.model.addEventListener("UPDATE_ITEM",__onUpdateItemHandler);
         AnswerManager.Instance.model.addEventListener("UPDATE_RESULT",__onResultHandler);
         AnswerManager.Instance.model.addEventListener("UPDATE_SELF_RANK",__onUpdateSelfRankHandler);
         AnswerManager.Instance.model.addEventListener("SHOW_REWARDS",__onShowRewardsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         AnswerManager.Instance.model.removeEventListener("UPDATE_RANK",__onUpdateRankHandler);
         AnswerManager.Instance.model.removeEventListener("UPDATE_ANSWER",__onUpdateAnswerHandler);
         AnswerManager.Instance.model.removeEventListener("UPDATE_STATE",__onUpdateStateHandler);
         AnswerManager.Instance.model.removeEventListener("UPDATE_ITEM",__onUpdateItemHandler);
         AnswerManager.Instance.model.removeEventListener("UPDATE_RESULT",__onResultHandler);
         AnswerManager.Instance.model.removeEventListener("UPDATE_SELF_RANK",__onUpdateSelfRankHandler);
         AnswerManager.Instance.model.removeEventListener("SHOW_REWARDS",__onShowRewardsHandler);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function __onShowRewardsHandler(param1:AnswerEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = LanguageMgr.GetTranslation("answer.view.alerttitle");
         if(AnswerManager.Instance.model.extraExp > 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("answer.view.rewards1",AnswerManager.Instance.model.totalSocre,AnswerManager.Instance.model.curExp,AnswerManager.Instance.model.extraExp);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("answer.view.rewards2",AnswerManager.Instance.model.totalSocre,AnswerManager.Instance.model.curExp);
         }
         _alert = AlertManager.Instance.simpleAlert(_loc2_,_loc3_,"","",true);
         _alert.addEventListener("response",__onResponseHandler);
      }
      
      private function __onUpdateSelfRankHandler(param1:AnswerEvent) : void
      {
         _rankView.setSelfRankInfo(AnswerManager.Instance.model.ranKing,AnswerManager.Instance.model.totalSocre,AnswerManager.Instance.model.curExp);
      }
      
      private function __onResultHandler(param1:AnswerEvent) : void
      {
         _questionV.result(param1.data.result,param1.data.score);
         _rankView.setSelfRankInfo(AnswerManager.Instance.model.ranKing,AnswerManager.Instance.model.totalSocre,AnswerManager.Instance.model.curExp);
      }
      
      private function __onUpdateRankHandler(param1:AnswerEvent) : void
      {
         _rankView.rankData = param1.data;
      }
      
      private function __onUpdateAnswerHandler(param1:AnswerEvent) : void
      {
         _questionV.data = param1.data as AnswerItemData;
      }
      
      private function __onUpdateStateHandler(param1:AnswerEvent) : void
      {
         _questionV.updateState(param1.data.state,param1.data.time);
         if(param1.data.state == 1)
         {
            _cdTime.setData(param1.data.time);
            _cdTime.show();
         }
         else
         {
            _cdTime.hide();
         }
      }
      
      private function __onUpdateItemHandler(param1:AnswerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.data as Array;
         var _loc4_:int = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            setItemCout(_loc2_[_loc3_].id,_loc2_[_loc3_].count,_loc2_[_loc3_].enble);
            _loc3_++;
         }
      }
      
      private function __onResponseHandler(param1:FrameEvent) : void
      {
         _alert.removeEventListener("response",__onResponseHandler);
         _alert.dispose();
         dispose();
      }
      
      public function setItemCout(param1:int, param2:int, param3:Boolean) : void
      {
         _questionV.setItemCout(param1,param2,param3);
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("answer.AnswerFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         LayerManager.Instance.addToLayer(ChatBar.instance,9,false,false);
         ChatBar.instance.chatBugleView.mouseChildren = false;
         ChatBar.instance.chatOutPutView.mouseChildren = false;
         KeyBoardRegister.instance.keyEnable = false;
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
      
      override public function dispose() : void
      {
         ChatBar.instance.show();
         ChatBar.instance.chatBugleView.mouseChildren = true;
         ChatBar.instance.chatOutPutView.mouseChildren = true;
         if(_cdTime)
         {
            _cdTime.hide();
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

