package rapidthrouh
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.rapidThrough.RapidThroughRankItemInfo;
   import yishi.datas.consant.JobType;
   
   public class RapidThrouhtRankItemView extends Component
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _captainNameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _job:FilterFrameText;
      
      private var _rankIcon:ScaleFrameImage;
      
      private var _shortLine:Image;
      
      private var _data:RapidThroughRankItemInfo;
      
      public function RapidThrouhtRankItemView()
      {
         super();
         initView();
      }
      
      public function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankItem.rankTxt");
         _captainNameTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankItem.captainNameTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankItem.timeTxt");
         _shortLine = ComponentFactory.Instance.creatComponentByStylename("topspeedrank.shortline");
         _shortLine.width = 527;
         _rankIcon = ComponentFactory.Instance.creatComponentByStylename("topspeedrank.RankListCellRankImg");
         _job = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankItem.memberNameTxt");
         addChild(_rankTxt);
         addChild(_rankIcon);
         addChild(_captainNameTxt);
         addChild(_job);
         addChild(_timeTxt);
         addChild(_shortLine);
      }
      
      public function set data(param1:RapidThroughRankItemInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(_data.order <= 3)
         {
            _rankTxt.visible = false;
            _rankIcon.visible = true;
            _rankIcon.setFrame(_data.order);
         }
         else
         {
            _rankTxt.visible = true;
            _rankIcon.visible = false;
            _rankTxt.text = _data.order + "";
         }
         _job.text = JobType.getJobName(_data.job);
         _timeTxt.text = _data.passTime;
         _captainNameTxt.text = _data.nickName;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_captainNameTxt);
         _captainNameTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_job);
         _job = null;
         ObjectUtils.disposeObject(_rankIcon);
         _rankIcon = null;
         ObjectUtils.disposeObject(_shortLine);
         _shortLine = null;
         super.dispose();
      }
   }
}

