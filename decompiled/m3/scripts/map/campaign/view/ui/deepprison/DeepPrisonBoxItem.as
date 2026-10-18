package map.campaign.view.ui.deepprison
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.CampaignManager;
   import map.campaign.data.DeepPrisonModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   
   public class DeepPrisonBoxItem extends Component
   {
      
      private var _boxImage:ScaleFrameImage;
      
      private var _achieveImage:Image;
      
      private var _needScoreTxt:FilterFrameText;
      
      private var _filter:UIFilter;
      
      private var _type:int;
      
      private var _index:int;
      
      private var _data:String;
      
      public function DeepPrisonBoxItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _boxImage = ComponentFactory.Instance.creatComponentByStylename("deepPrisonBoxItem.boxImage");
         _achieveImage = ComponentFactory.Instance.creatComponentByStylename("deepPrisonBoxItem.achieveImage");
         _needScoreTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonBoxItem.needScoreTxt");
         _filter = new UIFilter();
         _filter.setGrayFilter(_boxImage);
         _achieveImage.visible = false;
         addChild(_boxImage);
         addChild(_achieveImage);
         addChild(_needScoreTxt);
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set data(param1:String) : void
      {
         _data = param1;
         if(_data)
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         _boxImage.setFrame(_index + 1);
         var _loc5_:Array = _data.split(",");
         _loc2_ = int(_loc5_[0]);
         if(_type == 1)
         {
            _needScoreTxt.y = 60;
            _loc3_ = int(model.allScore);
         }
         else
         {
            _needScoreTxt.y = 55;
            _loc3_ = int(model.selfScore);
         }
         if(_loc3_ >= _loc2_)
         {
            _achieveImage.visible = true;
            _needScoreTxt.setFrame(1);
            _filter.setLightingFilter(_boxImage);
         }
         else
         {
            _achieveImage.visible = false;
            _filter.setGrayFilter(_boxImage);
            _needScoreTxt.setFrame(2);
         }
         _needScoreTxt.text = _loc2_.toString();
         var _loc1_:String = "";
         _loc6_ = 1;
         while(_loc6_ < _loc5_.length)
         {
            _loc4_ = _loc5_[_loc6_];
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc4_.split("_")[0];
            _loc7_.count = _loc4_.split("_")[1];
            _loc1_ += _loc7_.templateInfo.TemplateName + "*" + _loc7_.count;
            if(_loc6_ + 1 < _loc5_.length)
            {
               _loc1_ += "\n";
            }
            _loc6_++;
         }
         _boxImage.tipData = _loc1_;
      }
      
      private function get model() : DeepPrisonModel
      {
         return CampaignManager.instance.deepPrisonModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_boxImage);
         _boxImage = null;
         ObjectUtils.disposeObject(_achieveImage);
         _achieveImage = null;
         ObjectUtils.disposeObject(_needScoreTxt);
         _needScoreTxt = null;
         _filter = null;
         super.dispose();
      }
   }
}

