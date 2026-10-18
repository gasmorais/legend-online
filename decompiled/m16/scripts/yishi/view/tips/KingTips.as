package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.kingcontract.KingContractInfo;
   
   public class KingTips extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _day:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      public function KingTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg.width = 210;
         _title = ComponentFactory.Instance.creatComponentByStylename("kingcontract.tips.titleTxt");
         _day = ComponentFactory.Instance.creatComponentByStylename("kingcontract.tips.dayTxt");
         _describe = ComponentFactory.Instance.creatComponentByStylename("kingcontract.tips.DiscribeTxt");
         addChild(_title);
         addChild(_day);
         addChild(_describe);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:KingContractInfo = null;
         if(_data is KingContractInfo)
         {
            _loc1_ = _data as KingContractInfo;
            _title.text = _loc1_.template.Name;
            _day.text = LanguageMgr.GetTranslation("yishi.view.tips.KingTips.Limit");
            _day.x = _title.x + _title.textWidth + 5;
            _describe.text = _loc1_.template.Description;
            _describe.x = 10;
            _describe.y = 40;
            _describe.height = _describe.textHeight + _describe.numLines * 4;
            _bg.height = _describe.y + _describe.height + 15;
         }
         _bg.width = _day.x + _day.textWidth + 20;
         if(_bg.width < 190)
         {
            _bg.width = 190;
         }
      }
      
      override public function dispose() : void
      {
         _data = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_day)
         {
            ObjectUtils.disposeObject(_day);
         }
         _day = null;
         if(_describe)
         {
            ObjectUtils.disposeObject(_describe);
         }
         _describe = null;
         super.dispose();
      }
   }
}

