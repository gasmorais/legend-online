package map.campaign.view.ui.deepprison
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.CampaignManager;
   import map.campaign.data.DeepPrisonModel;
   import yishi.view.base.Progress;
   
   public class DeepPrisonScoreInfoItem extends Component
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _progressBg:Image;
      
      private var _progress:Progress;
      
      private var _index:int;
      
      private var _data:String;
      
      public function DeepPrisonScoreInfoItem()
      {
         super();
         initView();
      }
      
      public function set data(param1:String) : void
      {
         _data = param1;
         var _loc2_:Array = _data.split(",");
         _nameTxt.text = _loc2_[0].toString();
         _scoreTxt.text = _loc2_[1].toString();
         _progress.setData(_loc2_[1],model.selfMaxScore);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _progress = ComponentFactory.Instance.creatComponentByStylename("deepPrisonScoreInfoItem.progressBg" + _index);
         addChild(_progress);
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonScoreInfoItem.nameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonScoreInfoItem.scoreTxt");
         _progressBg = ComponentFactory.Instance.creatComponentByStylename("deepPrisonScoreInfoItem.progressBg");
         addChild(_nameTxt);
         addChild(_scoreTxt);
         addChild(_progressBg);
      }
      
      private function get model() : DeepPrisonModel
      {
         return CampaignManager.instance.deepPrisonModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         super.dispose();
      }
   }
}

