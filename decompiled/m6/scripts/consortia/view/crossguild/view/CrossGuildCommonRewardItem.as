package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class CrossGuildCommonRewardItem extends Component
   {
      
      private var _titleText:FilterFrameText;
      
      private var _line:Image;
      
      private var _rewardBox:HBox;
      
      private var showType:int;
      
      private var numStr:String;
      
      private var _data:Array;
      
      public function CrossGuildCommonRewardItem(param1:int)
      {
         super();
         showType = param1;
         initView();
      }
      
      private function initView() : void
      {
         _titleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildRankRewardItem.titleText");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildRankRewardItem.rewardBox");
         _line = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildRankRewardItem.line");
         addChild(_titleText);
         addChild(_rewardBox);
         addChild(_line);
      }
      
      public function setTitleText(param1:String) : void
      {
         numStr = param1;
         var _loc2_:Array = numStr.split(",");
         if(showType == 2)
         {
            _titleText.text = LanguageMgr.GetTranslation("CrossGuild.CrossGuildRankRewardItem.titleText.text2" + numStr);
         }
         else if(_loc2_.length > 1)
         {
            _titleText.text = _loc2_[0] + "-" + _loc2_[1];
         }
         else if(showType == 1)
         {
            _titleText.text = numStr;
         }
         else
         {
            _titleText.text = numStr + "+";
         }
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function set data(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc2_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         _data = param1;
         if(data)
         {
            _line.visible = true;
            _loc3_ = [];
            data.sortOn("itemId",16);
            for each(var _loc7_:CommonDropTempInfo in data)
            {
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc7_.itemId;
               _loc6_.count = _loc7_.count;
               _loc3_.push(_loc6_);
            }
            if(showType == 1)
            {
               if(numStr == "1")
               {
                  _loc4_ = 1;
                  while(_loc4_ <= 4)
                  {
                     _loc2_ = new GoodsInfo();
                     _loc2_.templateId = _loc4_;
                     _loc2_.blessValue = 0;
                     _loc3_.push(_loc2_);
                     _loc4_++;
                  }
               }
               else if(numStr == "2" || numStr == "3")
               {
                  _loc5_ = new GoodsInfo();
                  _loc5_.templateId = 4;
                  _loc5_.blessValue = int(numStr) - 1;
                  _loc3_.push(_loc5_);
               }
            }
            refreshRewardView(_loc3_);
         }
      }
      
      public function clean() : void
      {
         _titleText.text = "";
         _rewardBox.removeAllChild();
         _line.visible = false;
      }
      
      private function refreshRewardView(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RankIconRewardItem = null;
         _rewardBox.removeAllChild();
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new RankIconRewardItem();
            _loc4_.data = param1[_loc3_];
            _rewardBox.addChild(_loc4_);
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         super.dispose();
      }
   }
}

