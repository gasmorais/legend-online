package war2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.war2023.info.SecretWarRankInfo;
   import war2023.util.SecretwarBitDataUtil;
   
   public class SecretwarResultRankOneItem extends SecretwarRankOneItem
   {
      
      private var _fightScoreTxt:FilterFrameText;
      
      public var isSelf:Boolean;
      
      public function SecretwarResultRankOneItem()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _fightScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.RankItem.resultFightScoreTxt");
         addChild(_fightScoreTxt);
      }
      
      override public function set data(param1:SecretWarRankInfo) : void
      {
         super.data = param1;
         if(_data == null)
         {
            _fightScoreTxt.text = "";
         }
         if(_data.camp == 1)
         {
            _fightScoreTxt.setFrame(1);
         }
         else
         {
            _fightScoreTxt.setFrame(2);
         }
         if(isSelf)
         {
            _selfbg.bitmapData = SecretwarBitDataUtil.bitDatas[0];
         }
         else
         {
            _selfbg.bitmapData = SecretwarBitDataUtil.bitDatas[_data.camp];
         }
         if(_data.isReward)
         {
            _fightScoreTxt.text = _data.exploits.toString();
         }
         else
         {
            _fightScoreTxt.text = "0";
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_fightScoreTxt);
         _fightScoreTxt = null;
         super.dispose();
      }
   }
}

