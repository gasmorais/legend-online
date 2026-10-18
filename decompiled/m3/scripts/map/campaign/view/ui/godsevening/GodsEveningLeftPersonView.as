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
   
   public class GodsEveningLeftPersonView extends Component
   {
      
      private var _bg:Image;
      
      private var _rank:FilterFrameText;
      
      private var _nickName:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _itemList:Array;
      
      public function GodsEveningLeftPersonView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc1_:GodsEveningLeftPersonItem = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonView.Bg");
         _rank = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonView.Rank");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonView.NickName");
         _server = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonView.ServerName");
         _score = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonView.Score");
         addChild(_bg);
         addChild(_rank);
         addChild(_nickName);
         addChild(_server);
         addChild(_score);
         _rank.text = LanguageMgr.GetTranslation("godsEvening.rank");
         _nickName.text = LanguageMgr.GetTranslation("godsEvening.nickName");
         _server.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningLeftPersonView.teamTitle");
         _score.text = LanguageMgr.GetTranslation("godsEvening.score");
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new GodsEveningLeftPersonItem();
            _itemList.push(_loc1_);
            addChild(_loc1_);
            _loc1_.x = 10;
            _loc1_.y = 40 + _loc2_ * 26;
            _loc2_++;
         }
      }
      
      private function unInitView() : void
      {
         var _loc1_:GodsEveningLeftPersonItem = null;
         var _loc2_:int = 0;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rank);
         _rank = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
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
         GodsEveningManager.instance.addEventListener("PERSON_RANK_INFO",__infoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         GodsEveningManager.instance.removeEventListener("PERSON_RANK_INFO",__infoChangeHandler);
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
         var _loc1_:GodsEveningLeftPersonItem = null;
         var _loc2_:int = 0;
         var _loc3_:Dictionary = GodsEveningManager.instance.model.personRankDataDic;
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

