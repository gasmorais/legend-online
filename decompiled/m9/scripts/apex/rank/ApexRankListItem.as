package apex.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.apex.ApexRankTeamData;
   
   public class ApexRankListItem extends Component
   {
      
      private var _txtRankItemRank:FilterFrameText;
      
      private var _txtRankItemName:FilterFrameText;
      
      private var _imgRankItemStatus:ScaleFrameImage;
      
      private var _txtRankItemFP:FilterFrameText;
      
      private var _txtRankItemScore:FilterFrameText;
      
      private var _data:ApexRankTeamData;
      
      public function ApexRankListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txtRankItemRank = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankItemRank");
         _txtRankItemName = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankItemName");
         _imgRankItemStatus = ComponentFactory.Instance.creatComponentByStylename("ui.apex.imgRankItemStatus");
         _txtRankItemFP = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankItemFP");
         _txtRankItemScore = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtRankItemScore");
         addChild(_txtRankItemRank);
         addChild(_txtRankItemName);
         addChild(_imgRankItemStatus);
         addChild(_txtRankItemFP);
         addChild(_txtRankItemScore);
      }
      
      public function set data(param1:ApexRankTeamData) : void
      {
         _data = param1;
         if(_data)
         {
            _txtRankItemName.text = _data.teamName;
            _txtRankItemRank.text = _data.rank + "";
            _txtRankItemFP.text = _data.fightCapacity + "";
            _txtRankItemScore.text = _data.score + "";
            _imgRankItemStatus.visible = true;
            if(_data.group > _data.nextGroup)
            {
               _imgRankItemStatus.setFrame(1);
            }
            else if(_data.group < _data.nextGroup)
            {
               _imgRankItemStatus.setFrame(2);
            }
            else
            {
               _imgRankItemStatus.visible = false;
            }
         }
         else
         {
            _txtRankItemName.text = "";
            _txtRankItemRank.text = "";
            _txtRankItemFP.text = "";
            _txtRankItemScore.text = "";
            _imgRankItemStatus.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_txtRankItemRank);
         _txtRankItemRank = null;
         ObjectUtils.disposeObject(_txtRankItemName);
         _txtRankItemName = null;
         ObjectUtils.disposeObject(_imgRankItemStatus);
         _imgRankItemStatus = null;
         ObjectUtils.disposeObject(_txtRankItemFP);
         _txtRankItemFP = null;
         ObjectUtils.disposeObject(_txtRankItemScore);
         _txtRankItemScore = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

