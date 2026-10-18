package map.campaign.view.ui.snowball.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.data.ActiveVehicleUserInfo;
   
   public class SnowBallRankItem extends Component
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _dNameTxt:FilterFrameText;
      
      private var _dNumTxt:FilterFrameText;
      
      private var _data:ActiveVehicleUserInfo;
      
      public function SnowBallRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.dNameTxt");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.rankTxt");
         _dNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.snowball.dNumTxt");
         addChild(_rankTxt);
         addChild(_dNameTxt);
         addChild(_dNumTxt);
      }
      
      public function get data() : ActiveVehicleUserInfo
      {
         return _data;
      }
      
      public function set data(param1:ActiveVehicleUserInfo) : void
      {
         _data = param1;
         if(_data != null)
         {
            visible = true;
            _dNameTxt.text = _data.nickName;
            _rankTxt.text = _data.enterSeq + "";
            _dNumTxt.text = _data.pickSkillNum + "";
         }
         else
         {
            visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_dNameTxt);
         _dNameTxt = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_dNumTxt);
         _dNumTxt = null;
         super.dispose();
      }
   }
}

