package map.campaign.view.ui.godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GodsEveningEvent;
   import manager.LanguageMgr;
   import mvc.module.godsevening.GodsEveningModel;
   import yishi.manager.GodsEveningManager;
   
   public class GodsEveningSelfInfoView extends Component
   {
      
      private var _bg:MovieImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function GodsEveningSelfInfoView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("GodsEveningSelfInfoView.bg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("GodsEveningSelfInfoView.RankTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("GodsEveningSelfInfoView.ScoreTxt");
         addChild(_bg);
         addChild(_rankTxt);
         addChild(_scoreTxt);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
      }
      
      private function addEvent() : void
      {
         GodsEveningManager.instance.addEventListener("MY_INFO",__infoHandler);
         GodsEveningManager.instance.addEventListener("PERSON_RANK_INFO",__infoHandler);
      }
      
      private function removeEvent() : void
      {
         GodsEveningManager.instance.removeEventListener("MY_INFO",__infoHandler);
         GodsEveningManager.instance.removeEventListener("PERSON_RANK_INFO",__infoHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __infoHandler(param1:GodsEveningEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:GodsEveningModel = GodsEveningManager.instance.model;
         if(_loc1_.rank != 0)
         {
            _rankTxt.text = _loc1_.rank.toString();
         }
         else
         {
            _rankTxt.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningSelfInfoView.noRank");
         }
         _scoreTxt.text = _loc1_.score.toString();
      }
   }
}

