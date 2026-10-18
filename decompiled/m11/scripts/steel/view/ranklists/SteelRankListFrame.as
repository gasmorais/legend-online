package steel.view.ranklists
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.data.SteelTeamInfo;
   import map.campaign.event.SteelEvent;
   import mvc.controler.SteelController;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.PageUtils;
   
   public class SteelRankListFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _contentBg:Scale9CornerImage;
      
      private var _titleGap:MutipleImage;
      
      private var _itemVBox:VBox;
      
      private var _rankTitleTxt:FilterFrameText;
      
      private var _teamNameTitleTxt:FilterFrameText;
      
      private var _serverNameTitleTxt:FilterFrameText;
      
      private var _winCountTitleTxt:FilterFrameText;
      
      private var _fightTitleTxt:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _myWinCountTxt:FilterFrameText;
      
      private var _curPage:int;
      
      private var _perPageNum:int;
      
      private var _totalPage:int;
      
      private var _curList:Array;
      
      private var _itemList:Vector.<SteelRankItem>;
      
      private var _controller:SteelController;
      
      private var _model:SteelModel;
      
      public function SteelRankListFrame()
      {
         super();
         _controller = FrameControllerManager.instance.steelController;
         _model = _controller.model;
         _curPage = 1;
         _perPageNum = 10;
         initView();
         addEvent();
         _controller.sendSteelOrderListReq();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.Bg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.ContentBg");
         _titleGap = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.TitileGap");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.ItemVBox");
         _rankTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.RankTitleTxt");
         _teamNameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.TeamNameTitleTxt");
         _serverNameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.ServerNameTitleTxt");
         _winCountTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.WinCountTitleTxt");
         _fightTitleTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.FightTitleTxt");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.PageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.PrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.NextPageBtn");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.MyRankTxt");
         _myWinCountTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelRankListFrame.MyWinCountTxt");
         _rankTitleTxt.text = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.TitleTxt01");
         _teamNameTitleTxt.text = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.TitleTxt02");
         _serverNameTitleTxt.text = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.TitleTxt03");
         _winCountTitleTxt.text = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.TitleTxt04");
         _fightTitleTxt.text = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.TitleTxt05");
         addToContent(_bg);
         addToContent(_contentBg);
         addToContent(_titleGap);
         addToContent(_itemVBox);
         addToContent(_rankTitleTxt);
         addToContent(_teamNameTitleTxt);
         addToContent(_serverNameTitleTxt);
         addToContent(_winCountTitleTxt);
         addToContent(_fightTitleTxt);
         addToContent(_pageTxt);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_myRankTxt);
         addToContent(_myWinCountTxt);
         initItemListView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initItemListView() : void
      {
         var _loc1_:SteelRankItem = null;
         var _loc2_:int = 0;
         _itemList = new Vector.<SteelRankItem>();
         _loc2_ = 0;
         while(_loc2_ < _perPageNum)
         {
            _loc1_ = new SteelRankItem();
            _itemList.push(_loc1_);
            _itemVBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _model.addEventListener("STEEL_FINAL_ORDER_LIST_CHANGE",__finalOrderListChangeHandler);
         _prePageBtn.addEventListener("click",__onChangePageClick);
         _nextPageBtn.addEventListener("click",__onChangePageClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _model.removeEventListener("STEEL_FINAL_ORDER_LIST_CHANGE",__finalOrderListChangeHandler);
         _prePageBtn.removeEventListener("click",__onChangePageClick);
         _nextPageBtn.removeEventListener("click",__onChangePageClick);
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
      
      private function __finalOrderListChangeHandler(param1:SteelEvent) : void
      {
         refresh();
      }
      
      private function __onChangePageClick(param1:MouseEvent) : void
      {
         if(!param1)
         {
            return;
         }
         switch(param1.currentTarget)
         {
            case _nextPageBtn:
               _curPage = _curPage + 1;
               break;
            case _prePageBtn:
               _curPage = _curPage - 1;
         }
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         if(_model.selfOrder >= 1)
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.RankTxt01",_model.selfOrder);
         }
         else
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         _myWinCountTxt.text = _model.selfWinCount.toString();
         curPage = _curPage;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            if(_curList && _loc1_ < _curList.length)
            {
               _itemList[_loc1_].data = _curList[_loc1_] as SteelTeamInfo;
            }
            else
            {
               _itemList[_loc1_].data = null;
            }
            _loc1_++;
         }
      }
      
      private function get curPage() : int
      {
         return _curPage;
      }
      
      private function set curPage(param1:int) : void
      {
         _curPage = param1;
         var _loc2_:Array = _model.finalOrderList;
         _totalPage = PageUtils.getTotalPages(_loc2_,_perPageNum);
         if(_totalPage <= 0)
         {
            _totalPage = 1;
         }
         _curList = PageUtils.getTargetPageList(_loc2_,_curPage,_perPageNum) as Array;
         _pageTxt.text = _curPage + "/" + _totalPage;
         setPageEnable();
      }
      
      private function setPageEnable() : void
      {
         _prePageBtn.enable = _curPage > 1;
         _nextPageBtn.enable = _curPage < _totalPage;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

