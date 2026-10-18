package skyboxroad.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkyBoxRoadRankRewardTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class SkyBoxRoadRankRewardItem extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _orderImage:ScaleFrameImage;
      
      private var _orderTxt:FilterFrameText;
      
      private var _hBox:HBox;
      
      public function SkyBoxRoadRankRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.rankBg");
         _orderImage = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.orderImage");
         _orderTxt = ComponentFactory.Instance.creatComponentByStylename("skysecretareaItem.orderTxt");
         _hBox = ComponentFactory.Instance.creatCustomObject("skysecretarea.rankAwardHBox");
         addChild(_bg);
         _bg.width = 510;
         _bg.height = 85;
         addChild(_orderImage);
         addChild(_orderTxt);
         addChild(_hBox);
      }
      
      public function set data(param1:Array) : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc2_:BaseItemView = null;
         if(!param1)
         {
            return;
         }
         _hBox.removeAllChild();
         var _loc3_:int = int(param1.length);
         var _loc6_:SkyBoxRoadRankRewardTempInfo = param1[0];
         if(_loc6_.Min <= 3)
         {
            _orderImage.visible = true;
            _orderTxt.visible = false;
            _orderImage.setFrame(_loc6_.Min);
         }
         else
         {
            _orderImage.visible = false;
            _orderTxt.visible = true;
            if(_loc6_.Min == _loc6_.Max)
            {
               _orderTxt.text = LanguageMgr.GetTranslation("warlords.WarlordsGeneralListCell.str02",_loc6_.Min);
            }
            else
            {
               _orderTxt.text = LanguageMgr.GetTranslation("skysecretareaView.rankTips03",_loc6_.Min,_loc6_.Max);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("skysecretarea.rankBaseItem");
            _loc6_ = param1[_loc5_];
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc6_.TemplateId;
            _loc4_.count = _loc6_.Count;
            _loc2_.data = _loc4_;
            _hBox.addChild(_loc2_);
            _loc5_ += 1;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_hBox);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_orderTxt);
         _orderTxt = null;
         ObjectUtils.disposeObject(_orderImage);
         _orderImage = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

