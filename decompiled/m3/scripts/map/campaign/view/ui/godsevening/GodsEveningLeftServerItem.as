package map.campaign.view.ui.godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.godsevening.GERankItemServerData;
   
   public class GodsEveningLeftServerItem extends Component
   {
      
      private var _rank:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _data:GERankItemServerData;
      
      public function GodsEveningLeftServerItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonItem.lineImg");
         _rank = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftServerItem.Rank");
         _server = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftServerItem.ServerName");
         _score = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftServerItem.Score");
         addChild(_line);
         addChild(_rank);
         addChild(_server);
         addChild(_score);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_rank);
         _rank = null;
         ObjectUtils.disposeObject(_server);
         _server = null;
         ObjectUtils.disposeObject(_score);
         _score = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
      }
      
      override public function dispose() : void
      {
         unInitView();
         super.dispose();
      }
      
      private function refreshView() : void
      {
         _rank.setFrame(data.teamId);
         _server.setFrame(data.teamId);
         _score.setFrame(data.teamId);
         _rank.text = data.rank.toString();
         _server.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningLeftPersonItem.team" + data.teamId);
         _score.text = data.score.toString();
      }
      
      public function get data() : GERankItemServerData
      {
         return _data;
      }
      
      public function set data(param1:GERankItemServerData) : void
      {
         if(param1)
         {
            _data = param1;
            refreshView();
         }
      }
   }
}

