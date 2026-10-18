package dreamarena
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dreamarena.view.DreamArenaRankView;
   import dreamarena.view.DreamArenaRewardView;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   
   public class DreamArenaRankRewardFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _btnHbox:HBox;
      
      private var _rankBtn:SelectedIconButton;
      
      private var _rewardBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _myRankText:FilterFrameText;
      
      private var _myScoreText:FilterFrameText;
      
      private var _rankView:DreamArenaRankView;
      
      private var _rewardView:DreamArenaRewardView;
      
      public function DreamArenaRankRewardFrame()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
         DreamArenaManager.instance.sendDreamArenaRequest(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,483,406);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankRewardFrame.border");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankRewardFrame.btnHbox");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankRewardFrame.rankBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankRewardFrame.rewardBtn");
         _myRankText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankRewardFrame.myRankText");
         _myScoreText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankRewardFrame.myScoreText");
         addToContent(_border);
         addToContent(_btnHbox);
         addToContent(_myRankText);
         addToContent(_myScoreText);
         _btnHbox.addChild(_rankBtn);
         _btnHbox.addChild(_rewardBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_rankBtn);
         _btnGroup.addSelectItem(_rewardBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("RANK_LIST_BACK",this,__rankListBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         MsgMan.removeObserver("RANK_LIST_BACK",this,__rankListBackHandler);
      }
      
      private function __rankListBackHandler(param1:String, param2:Object) : void
      {
         refreshView();
         if(_rankView)
         {
            _rankView.refreshListView();
         }
         if(_rewardView)
         {
            _rewardView.refreshView();
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _rankBtn:
               ObjectUtils.disposeObject(_rewardView);
               _rewardView = null;
               if(!_rankView)
               {
                  _rankView = ComponentFactory.Instance.creatCustomObject("DreamArenaRankRewardFrame.RankView");
               }
               addToContent(_rankView);
               _rankView.refreshListView();
               break;
            case _rewardBtn:
               ObjectUtils.disposeObject(_rankView);
               _rankView = null;
               if(!_rewardView)
               {
                  _rewardView = ComponentFactory.Instance.creatCustomObject("DreamArenaRankRewardFrame.RewardView");
               }
               addToContent(_rewardView);
               _rewardView.refreshView();
         }
      }
      
      private function refreshView() : void
      {
         _myRankText.text = LanguageMgr.GetTranslation("warlords.room.WarlordsFinalRoomRightView.selfRank",model.myRank);
         _myScoreText.text = LanguageMgr.GetTranslation("childarena.myScore",model.myScore);
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
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("CrossGuildRankFrame.titleText.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_myRankText);
         _myRankText = null;
         ObjectUtils.disposeObject(_myScoreText);
         _myScoreText = null;
         super.dispose();
      }
   }
}

