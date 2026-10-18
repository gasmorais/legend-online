package map.campaign.view.ui.godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.godsevening.GERankItemPersonData;
   
   public class GodsEveningLeftPersonItem extends Component
   {
      
      private var _rank:FilterFrameText;
      
      private var _nickName:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _data:GERankItemPersonData;
      
      public function GodsEveningLeftPersonItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonItem.lineImg");
         _rank = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonItem.Rank");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonItem.NickName");
         _server = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonItem.ServerName");
         _score = ComponentFactory.Instance.creatComponentByStylename("GodsEveningLeftPersonItem.Score");
         addChild(_line);
         addChild(_rank);
         addChild(_nickName);
         addChild(_server);
         addChild(_score);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_rank);
         _rank = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
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
         _rank.text = data.rank.toString();
         _nickName.text = data.nickName;
         _server.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningLeftPersonItem.team" + data.teamId);
         _score.text = data.score.toString();
         _rank.setFrame(data.teamId);
         _nickName.setFrame(data.teamId);
         _server.setFrame(data.teamId);
         _score.setFrame(data.teamId);
      }
      
      public function get data() : GERankItemPersonData
      {
         return _data;
      }
      
      public function set data(param1:GERankItemPersonData) : void
      {
         if(param1)
         {
            _data = param1;
            refreshView();
         }
      }
   }
}

