package map.campaign.view.ui.godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GodsEveningEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.manager.GodsEveningManager;
   
   public class GodsEveningLeftServerView extends Component
   {
      
      private var _bg:Image;
      
      private var _rank:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _itemList:Array;
      
      public function GodsEveningLeftServerView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:GodsEveningLeftServerItem = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonView.Bg");
         _rank = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftServerView.Rank");
         _server = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftServerView.ServerName");
         _score = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftServerView.Score");
         addChild(_bg);
         addChild(_rank);
         addChild(_server);
         addChild(_score);
         _rank.text = LanguageMgr.GetTranslation("godsEvening.rank");
         _server.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningLeftPersonView.teamTitle");
         _score.text = LanguageMgr.GetTranslation("godsEvening.score");
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new GodsEveningLeftServerItem();
            _itemList.push(_loc1_);
            addChild(_loc1_);
            _loc1_.x = 10;
            _loc1_.y = 40 + _loc2_ * 26;
            _loc2_++;
         }
      }
      
      private function unInitView() : void
      {
         var _loc1_:GodsEveningLeftServerItem = null;
         var _loc2_:int = 0;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rank);
         _rank = null;
         ObjectUtils.disposeObject(_server);
         _server = null;
         ObjectUtils.disposeObject(_score);
         _score = null;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = _itemList[_loc2_];
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         GodsEveningManager.instance.addEventListener("SERVER_RANK_INFO",__infoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         GodsEveningManager.instance.removeEventListener("SERVER_RANK_INFO",__infoChangeHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __infoChangeHandler(param1:GodsEveningEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:GodsEveningLeftServerItem = null;
         var _loc2_:int = 0;
         var _loc3_:Dictionary = GodsEveningManager.instance.model.serverRankDataDic;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.data = _loc3_[_loc2_ + 1];
            _loc2_++;
         }
      }
   }
}

