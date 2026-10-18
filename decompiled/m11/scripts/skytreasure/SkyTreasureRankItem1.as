package skytreasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class SkyTreasureRankItem1 extends Component
   {
      
      private var _back:Image;
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _rewardText:FilterFrameText;
      
      private var _data:Object;
      
      public function SkyTreasureRankItem1()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankItemBack");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankItemRankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankItemNameText");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankItemScoreText");
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankItemRewardText");
         addChild(_back);
         addChild(_rankText);
         addChild(_nameText);
         addChild(_scoreText);
         addChild(_rewardText);
      }
      
      public function setData(param1:Object, param2:int) : void
      {
         _data = param1;
         if(_data)
         {
            _rankText.text = param2.toString();
            _nameText.text = _data.playerName;
            _scoreText.text = _data.score.toString();
            _rewardText.text = _data.reward;
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_scoreText);
         _scoreText = null;
         ObjectUtils.disposeObject(_rewardText);
         _rewardText = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

