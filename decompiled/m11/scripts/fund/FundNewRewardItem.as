package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.FundInfo;
   import mvc.module.fund.GItemInfo;
   import mvc.module.fund.GetItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   
   public class FundNewRewardItem extends Component
   {
      
      public const LE_PROFILE_LIMIT:int = 5;
      
      public const HBOX_PADDING:int = 60;
      
      private var _getTime:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _container:Component;
      
      private var _hBox1:HBox;
      
      private var _hBox2:HBox;
      
      private var _data:GetItemInfo;
      
      private var _model:FundInfo;
      
      private var _splitLine:Bitmap;
      
      public function FundNewRewardItem()
      {
         super();
         _model = FundManager.instance.model;
         initView();
      }
      
      private function initView() : void
      {
         _getTime = ComponentFactory.Instance.creatComponentByStylename("fund.totalgetTxt_3");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("fundNewRewardItem.itemListDouble");
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("fundNewRewardItem.hBox");
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("fundNewRewardItem.hBox");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.fundnew.splitLine2");
         _container = new Component();
         _hBox2.y = _hBox1.y + 60;
         _container.addChild(_hBox1);
         _container.addChild(_hBox2);
         _scrollPanel.setView(_container,true);
         addChild(_getTime);
         addChild(_scrollPanel);
         addChild(_splitLine);
         _scrollPanel.invalidateViewport(true);
         _scrollPanel.commitChanges();
      }
      
      private function uninitView() : void
      {
         if(_hBox1)
         {
            ObjectUtils.disposeAllChildren(_hBox1);
         }
         if(_hBox2)
         {
            ObjectUtils.disposeAllChildren(_hBox2);
         }
         if(_container)
         {
            ObjectUtils.disposeAllChildren(_container);
         }
         if(_scrollPanel)
         {
            ObjectUtils.disposeAllChildren(_scrollPanel);
         }
         if(_getTime)
         {
            ObjectUtils.disposeObject(_getTime);
         }
         _getTime = null;
         if(_splitLine)
         {
            ObjectUtils.disposeObject(_splitLine);
         }
         _splitLine = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      public function set data(param1:GetItemInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FundNewDoubleGiftItem = null;
         if(_hBox1)
         {
            _hBox1.disposeAllChildren();
         }
         if(_hBox2)
         {
            _hBox2.disposeAllChildren();
         }
         if(_scrollPanel)
         {
            _scrollPanel.beginChanges();
         }
         if(_getTime)
         {
            _getTime.text = LanguageMgr.GetTranslation("fund.FundNewRewardView.getTime.text",DateFormatter.transDate(_model.getStartDate + _data.interval * 60));
         }
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = new FundNewDoubleGiftItem(_loc2_);
            if(_loc2_ == 0)
            {
               setBagData(_data.itemInfos,_hBox1);
            }
            else if(_loc2_ == 1)
            {
               setBagData(_data.itemInfos2,_hBox2);
            }
            _loc1_.data = _data;
            addChild(_loc1_);
            _loc1_.index = _loc2_;
            _loc1_.y = _loc2_ * 62 + 26;
            _loc2_++;
         }
         if(_hBox1.width > _hBox2.width)
         {
            _container.width = _hBox1.width;
         }
         else
         {
            _container.width = _hBox2.width;
         }
         if(_scrollPanel)
         {
            _scrollPanel.invalidateViewport(true);
            _scrollPanel.commitChanges();
         }
      }
      
      private function setBagData(param1:Array, param2:HBox) : void
      {
         var _loc3_:GItemInfo = null;
         var _loc5_:int = 0;
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc8_:GoodsTemplateInfo = null;
         var _loc7_:MovieImage = null;
         if(!param1)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = param1[_loc5_] as GItemInfo;
            _loc4_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc3_.templateId;
            _loc6_.count = _loc3_.count;
            _loc6_.showCount = true;
            _loc4_.data = _loc6_;
            if(param2)
            {
               param2.addChild(_loc4_);
            }
            _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.templateId);
            if(_loc8_ && _loc8_.Profile >= 5)
            {
               _loc7_ = ComponentFactory.Instance.creatComponentByStylename("fundnewReward.LightEffect");
               _loc7_.mouseEnabled = false;
               _loc7_.mouseChildren = false;
               _loc7_.x = _loc4_.x + 26;
               _loc7_.y = param2.y - 29;
               if(_container)
               {
                  _container.addChild(_loc7_);
               }
            }
            _loc5_++;
         }
      }
      
      override public function dispose() : void
      {
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

