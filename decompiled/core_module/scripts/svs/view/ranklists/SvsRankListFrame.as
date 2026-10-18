package svs.view.ranklists
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
   import map.campaign.data.SvsModel;
   import map.campaign.data.SvsServerInfo;
   import map.campaign.event.SvsEvent;
   import mvc.controler.SvsController;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.PageUtils;
   
   public class SvsRankListFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _contentBg:Scale9CornerImage;
      
      private var _titleGap:MutipleImage;
      
      private var _itemVBox:VBox;
      
      private var _rankTitleTxt:FilterFrameText;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _fightTitleTxt:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _myRankTxt:FilterFrameText;
      
      private var _myFightTxt:FilterFrameText;
      
      private var _curPage:int;
      
      private var _perPageNum:int;
      
      private var _totalPage:int;
      
      private var _curList:Array;
      
      private var _itemList:Vector.<SvsRankItem>;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      public function SvsRankListFrame()
      {
         super();
         _controller = FrameControllerManager.instance.svsController;
         _model = _controller.model;
         _curPage = 1;
         _perPageNum = 8;
         initView();
         addEvent();
         _controller.sendSvsFinalInfoReq();
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
         titleText = LanguageMgr.GetTranslation("svs.view.ranklists.SvsRankListFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.Bg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.ContentBg");
         _titleGap = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.TitileGap");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.ItemVBox");
         _rankTitleTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.RankTitleTxt");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.NameTitleTxt");
         _fightTitleTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.FightTitleTxt");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.PageTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.PrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.NextPageBtn");
         _myRankTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.MyRankTxt");
         _myFightTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankListFrame.MyFightTxt");
         _rankTitleTxt.text = LanguageMgr.GetTranslation("svs.view.ranklists.SvsRankListFrame.TitleTxt01");
         _nameTitleTxt.text = LanguageMgr.GetTranslation("svs.view.ranklists.SvsRankListFrame.TitleTxt02");
         _fightTitleTxt.text = LanguageMgr.GetTranslation("svs.view.ranklists.SvsRankListFrame.TitleTxt03");
         addToContent(_bg);
         addToContent(_contentBg);
         addToContent(_titleGap);
         addToContent(_itemVBox);
         addToContent(_rankTitleTxt);
         addToContent(_nameTitleTxt);
         addToContent(_fightTitleTxt);
         addToContent(_pageTxt);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_myRankTxt);
         addToContent(_myFightTxt);
         initItemListView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initItemListView() : void
      {
         var _loc1_:SvsRankItem = null;
         var _loc2_:int = 0;
         _itemList = new Vector.<SvsRankItem>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new SvsRankItem();
            _itemList.push(_loc1_);
            _itemVBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _model.addEventListener("SVS_FINAL_ORDER_LIST_CHANGE",__finalOrderListChangeHandler);
         _prePageBtn.addEventListener("click",__onChangePageClick);
         _nextPageBtn.addEventListener("click",__onChangePageClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _model.removeEventListener("SVS_FINAL_ORDER_LIST_CHANGE",__finalOrderListChangeHandler);
         _prePageBtn.removeEventListener("click",__onChangePageClick);
         _nextPageBtn.removeEventListener("click",__onChangePageClick);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __finalOrderListChangeHandler(param1:SvsEvent) : void
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
         if(_model.selfOrder >= 1 && _model.selfOrder <= 16)
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("svs.view.ranklists.SvsRankListFrame.RankTxt01",_model.selfOrder);
         }
         else if(_model.selfOrder > 16)
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("svs.view.ranklists.SvsRankListFrame.RankTxt02",_model.selfOrder);
         }
         else
         {
            _myRankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         _myFightTxt.text = _model.selfFightPower.toString();
         curPage = _curPage;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            if(_curList && _loc1_ < _curList.length)
            {
               _itemList[_loc1_].data = _curList[_loc1_] as SvsServerInfo;
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

