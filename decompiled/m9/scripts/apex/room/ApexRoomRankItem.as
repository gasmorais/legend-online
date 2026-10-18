package apex.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.apex.ApexRankTeamData;
   
   public class ApexRoomRankItem extends Component
   {
      
      private var _txtRoomRankName:FilterFrameText;
      
      private var _txtRoomRankRank:FilterFrameText;
      
      private var _txtRoomRankScore:FilterFrameText;
      
      public function ApexRoomRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txtRoomRankName = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomRankName");
         _txtRoomRankRank = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomRankRank");
         _txtRoomRankScore = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomRankScore");
         addChild(_txtRoomRankName);
         addChild(_txtRoomRankRank);
         addChild(_txtRoomRankScore);
      }
      
      public function set data(param1:ApexRankTeamData) : void
      {
         _txtRoomRankName.text = param1.teamName;
         _txtRoomRankRank.text = param1.rank + "";
         _txtRoomRankScore.text = param1.score + "";
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_txtRoomRankName);
         _txtRoomRankName = null;
         ObjectUtils.disposeObject(_txtRoomRankRank);
         _txtRoomRankRank = null;
         ObjectUtils.disposeObject(_txtRoomRankScore);
         _txtRoomRankScore = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

