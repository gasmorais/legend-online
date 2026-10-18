package consortiachess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.item.ChesspvpRankItem;
   import consortiachess.item.ChesspvpRankSelfItem;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.view.base.PageBar;
   
   public class ChesspvpRankView extends Sprite
   {
      
      private var _bg2:Bitmap;
      
      private var _vBox:VBox;
      
      private var _itemList:Array = [];
      
      private var _self:ChesspvpRankSelfItem;
      
      private var _pageBar:PageBar;
      
      private var _rankTitle:FilterFrameText;
      
      private var _nameTitle:FilterFrameText;
      
      private var _powTitle:FilterFrameText;
      
      private var _scoreTitle:FilterFrameText;
      
      private var _desTitle:FilterFrameText;
      
      private var _timeDesTxt:FilterFrameText;
      
      public function ChesspvpRankView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rank.bg");
         _self = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.ChesspvpRankSelfItem");
         _vBox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.rank.vbox");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.pagebar");
         _rankTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.rankTitleTxt");
         _nameTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.nameTitleTxt");
         _powTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.powTitleText");
         _scoreTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.scoreTitleTxt");
         _desTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.desTitle");
         _timeDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rank.timedesTxt");
         _rankTitle.text = LanguageMgr.GetTranslation("chesspvp.rank.cTitle");
         _nameTitle.text = LanguageMgr.GetTranslation("chesspvp.rank.cname");
         _powTitle.text = LanguageMgr.GetTranslation("chesspvp.rank.powName");
         _scoreTitle.text = LanguageMgr.GetTranslation("chesspvp.rank.cScore");
         _timeDesTxt.text = LanguageMgr.GetTranslation("chesspvp.rank.sortTime");
         addChild(_bg2);
         addChild(_rankTitle);
         addChild(_nameTitle);
         addChild(_powTitle);
         addChild(_scoreTitle);
         addChild(_desTitle);
         addChild(_timeDesTxt);
         addChild(_vBox);
         addChild(_pageBar);
         addChild(_self);
      }
      
      public function refreshData(param1:Array, param2:int) : void
      {
         _desTitle.text = LanguageMgr.GetTranslation("chesspvp.rank.des" + param2);
         if(param1 != null)
         {
            param1.sortOn("rank",16);
         }
         _pageBar.setAutoPagingData(param1,8);
         _pageBar.setCurPage(1);
      }
      
      private function initEvent() : void
      {
         _pageBar.addEventListener("change",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         _pageBar.removeEventListener("change",__changeHandler);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         var _loc2_:ChesspvpRankItem = null;
         var _loc4_:int = 0;
         var _loc5_:Array = _pageBar.getCurPageDatas();
         var _loc3_:int = int(_loc5_ ? _loc5_.length : 0);
         _vBox.removeAllChild();
         _vBox.beginChanges();
         var _loc6_:int = int(_itemList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc4_ < _loc6_)
            {
               _loc2_ = _itemList[_loc4_];
            }
            else
            {
               _loc2_ = new ChesspvpRankItem();
               _itemList.push(_loc2_);
            }
            _loc2_.data = _loc5_[_loc4_];
            _vBox.addChild(_loc2_);
            _loc4_++;
         }
         _vBox.commitChanges();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_self);
         _self = null;
         ObjectUtils.disposeObject(_rankTitle);
         _rankTitle = null;
         ObjectUtils.disposeObject(_nameTitle);
         _nameTitle = null;
         ObjectUtils.disposeObject(_powTitle);
         _powTitle = null;
         ObjectUtils.disposeObject(_scoreTitle);
         _scoreTitle = null;
         ObjectUtils.disposeObject(_timeDesTxt);
         _timeDesTxt = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_desTitle);
         _desTitle = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

