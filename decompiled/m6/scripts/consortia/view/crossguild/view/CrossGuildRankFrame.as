package consortia.view.crossguild.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.CrossGuildManager;
   import yishi.utils.MsgMan;
   
   public class CrossGuildRankFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _btnHbox:HBox;
      
      private var _rankBtn:SelectedIconButton;
      
      private var _seasonBtn:SelectedIconButton;
      
      private var _singleWarBtn:SelectedIconButton;
      
      private var _contributionBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _rankView:CrossGuildRankView;
      
      private var _commonRewardView:CrossGuildCommonRewardView;
      
      public function CrossGuildRankFrame()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
         CrossGuildManager.instance.sendFrameRequest(4);
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
         _border = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildRankFrame.border");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankFrame.btnHbox");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankFrame.rankBtn");
         _seasonBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankFrame.seasonBtn");
         _singleWarBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankFrame.singleWarBtn");
         _contributionBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankFrame.contributionBtn");
         addToContent(_border);
         addToContent(_btnHbox);
         _btnHbox.addChild(_rankBtn);
         _btnHbox.addChild(_seasonBtn);
         _btnHbox.addChild(_singleWarBtn);
         _btnHbox.addChild(_contributionBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_rankBtn);
         _btnGroup.addSelectItem(_seasonBtn);
         _btnGroup.addSelectItem(_singleWarBtn);
         _btnGroup.addSelectItem(_contributionBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("CROSS_GUILD_SEASON_RANK",this,__seasonRankBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("CROSS_GUILD_SEASON_RANK",this,__seasonRankBackHandler);
      }
      
      private function __seasonRankBackHandler(param1:String, param2:Object) : void
      {
         if(_rankView)
         {
            _rankView.refreshListView();
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _rankBtn:
               ObjectUtils.disposeObject(_commonRewardView);
               _commonRewardView = null;
               if(!_rankView)
               {
                  _rankView = ComponentFactory.Instance.creatCustomObject("CrossGuildRankView.CrossGuildRankView");
               }
               addToContent(_rankView);
               _rankView.refreshListView();
               break;
            case _seasonBtn:
            case _singleWarBtn:
            case _contributionBtn:
               ObjectUtils.disposeObject(_rankView);
               _rankView = null;
               if(!_commonRewardView)
               {
                  _commonRewardView = ComponentFactory.Instance.creatCustomObject("CrossGuildRankView.CrossGuildCommonRewardView");
               }
               addToContent(_commonRewardView);
               _commonRewardView.refreshView(_btnGroup.selectIndex);
         }
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
         titleText = LanguageMgr.GetTranslation("CrossGuildRankFrame.titleText.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_seasonBtn);
         _seasonBtn = null;
         ObjectUtils.disposeObject(_singleWarBtn);
         _singleWarBtn = null;
         ObjectUtils.disposeObject(_contributionBtn);
         _contributionBtn = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_commonRewardView);
         _commonRewardView = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         super.dispose();
      }
   }
}

