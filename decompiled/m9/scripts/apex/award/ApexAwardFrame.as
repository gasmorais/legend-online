package apex.award
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ApexRewardDropTemp;
   import yishi.manager.TempleteManager;
   import yishi.utils.HashMap;
   
   public class ApexAwardFrame extends Frame
   {
      
      private var _txtAwardRank:FilterFrameText;
      
      private var _txtAwardContent:FilterFrameText;
      
      private var _txtAwardContent2:FilterFrameText;
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var _bit4:Bitmap;
      
      private var btnTab1:SelectedIconButton;
      
      private var btnTab2:SelectedIconButton;
      
      private var btnTab3:SelectedIconButton;
      
      private var btnTab4:SelectedIconButton;
      
      private var btnTab5:SelectedIconButton;
      
      private var btnTab6:SelectedIconButton;
      
      private var hbox:HBox;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var awardMap:HashMap;
      
      private var awardBox1:HBox;
      
      private var awardBox2:HBox;
      
      private var awardBox3:HBox;
      
      public function ApexAwardFrame()
      {
         super();
         initView();
         addEvent();
         _buttonGroup.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         awardMap = new HashMap();
         _txtAwardRank = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardRank");
         _txtAwardContent = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardContent");
         _txtAwardContent2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtAwardContent2");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.str.awardList");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.str.1th");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.apex.str.2th");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.apex.str.3th");
         _bit4 = ComponentFactory.Instance.creatBitmap("asset.apex.award.bg");
         addChild(_bit4);
         addChild(_txtAwardRank);
         addChild(_txtAwardContent);
         addChild(_txtAwardContent2);
         addChild(_bit0);
         addChild(_bit1);
         addChild(_bit2);
         addChild(_bit3);
         hbox = ComponentFactory.Instance.creatComponentByStylename("apex.hbox.award.hbox");
         awardBox1 = ComponentFactory.Instance.creatComponentByStylename("apex.hbox.award.grade.hbox1");
         awardBox2 = ComponentFactory.Instance.creatComponentByStylename("apex.hbox.award.grade.hbox2");
         awardBox3 = ComponentFactory.Instance.creatComponentByStylename("apex.hbox.award.grade.hbox3");
         btnTab1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.award.textBt1");
         btnTab2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.award.textBt2");
         btnTab3 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.award.textBt3");
         btnTab4 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.award.textBt4");
         btnTab5 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.award.textBt5");
         btnTab6 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.award.textBt6");
         hbox.addChild(btnTab1);
         hbox.addChild(btnTab2);
         hbox.addChild(btnTab3);
         hbox.addChild(btnTab4);
         hbox.addChild(btnTab5);
         hbox.addChild(btnTab6);
         addChild(hbox);
         addChild(awardBox1);
         addChild(awardBox2);
         addChild(awardBox3);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(btnTab1);
         _buttonGroup.addSelectItem(btnTab2);
         _buttonGroup.addSelectItem(btnTab3);
         _buttonGroup.addSelectItem(btnTab4);
         _buttonGroup.addSelectItem(btnTab5);
         _buttonGroup.addSelectItem(btnTab6);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buttonGroup.addEventListener("change",__tabChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _buttonGroup.removeEventListener("change",__tabChangeHandler);
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         var _loc11_:Array = null;
         var _loc4_:ApexAwardItem = null;
         var _loc10_:int = 0;
         if(awardMap)
         {
            awardMap.clear();
         }
         var _loc3_:int = 6 - _buttonGroup.selectIndex;
         clearHbox();
         _txtAwardRank.text = "";
         _txtAwardContent.text = "";
         _txtAwardContent2.text = "";
         var _loc12_:Array = TempleteManager.instance.apexRankRewardDropTempCate.getGradeDrop(_loc3_);
         var _loc7_:Array = [];
         for each(var _loc2_:ApexRewardDropTemp in _loc12_)
         {
            _loc11_ = awardMap.getValue(_loc2_.sort) as Array;
            if(!_loc11_)
            {
               _loc11_ = [];
            }
            _loc11_.push(_loc2_);
            awardMap.put(_loc2_.sort,_loc11_);
            if(_loc7_.indexOf(_loc2_.sort) < 0)
            {
               _loc7_.push(_loc2_.sort);
            }
         }
         _loc7_.sort(16);
         _loc10_ = 0;
         while(_loc10_ < _loc7_.length)
         {
            _loc11_ = awardMap.getValue(_loc7_[_loc10_]) as Array;
            if(_loc7_[_loc10_] == 1)
            {
               for each(_loc2_ in _loc11_)
               {
                  _loc4_ = new ApexAwardItem();
                  _loc4_.data = _loc2_;
                  awardBox1.addChild(_loc4_);
               }
            }
            else if(_loc7_[_loc10_] == 2)
            {
               for each(_loc2_ in _loc11_)
               {
                  _loc4_ = new ApexAwardItem();
                  _loc4_.data = _loc2_;
                  awardBox2.addChild(_loc4_);
               }
            }
            else if(_loc7_[_loc10_] == 3)
            {
               for each(_loc2_ in _loc11_)
               {
                  _loc4_ = new ApexAwardItem();
                  _loc4_.data = _loc2_;
                  awardBox3.addChild(_loc4_);
               }
            }
            else
            {
               _txtAwardRank.appendText((_loc11_[0] as ApexRewardDropTemp).rankStr + "\n");
               for each(_loc2_ in _loc11_)
               {
                  _txtAwardContent.appendText(_loc2_.nameAndCount + " ");
               }
               _txtAwardContent.appendText("\n");
            }
            _loc10_++;
         }
         var _loc8_:String = "";
         var _loc9_:String = "";
         var _loc5_:String = "";
         var _loc6_:String = "";
         _loc12_ = TempleteManager.instance.apexRankRewardDropTempCate.getTurnDrop(1,_loc3_);
         for each(_loc2_ in _loc12_)
         {
            _loc8_ += _loc2_.nameAndCount + " ";
         }
         _loc8_ = LanguageMgr.GetTranslation("apex.award.str2",_loc8_) + "\n";
         _loc12_ = TempleteManager.instance.apexRankRewardDropTempCate.getTurnDrop(2,_loc3_);
         for each(_loc2_ in _loc12_)
         {
            _loc9_ += _loc2_.nameAndCount + " ";
         }
         _loc9_ = LanguageMgr.GetTranslation("apex.award.str3",_loc9_) + "\n";
         _loc12_ = TempleteManager.instance.apexRankRewardDropTempCate.getTurnDrop(3,_loc3_);
         for each(_loc2_ in _loc12_)
         {
            _loc5_ += _loc2_.nameAndCount + " ";
         }
         _loc5_ = LanguageMgr.GetTranslation("apex.award.str4",_loc5_) + "\n";
         _loc12_ = TempleteManager.instance.apexRankRewardDropTempCate.getTurnDrop(4,_loc3_);
         for each(_loc2_ in _loc12_)
         {
            _loc6_ += _loc2_.nameAndCount + " ";
         }
         _loc6_ = LanguageMgr.GetTranslation("apex.award.str5",_loc6_) + "\n";
         _txtAwardContent2.text = _loc8_ + _loc9_ + _loc5_ + _loc6_;
      }
      
      private function clearHbox() : void
      {
         while(awardBox1.numChildren > 0)
         {
            (awardBox1.getChildAt(0) as ApexAwardItem).dispose();
         }
         while(awardBox2.numChildren > 0)
         {
            (awardBox2.getChildAt(0) as ApexAwardItem).dispose();
         }
         while(awardBox3.numChildren > 0)
         {
            (awardBox3.getChildAt(0) as ApexAwardItem).dispose();
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_txtAwardRank);
         _txtAwardRank = null;
         ObjectUtils.disposeObject(_txtAwardContent);
         _txtAwardContent = null;
         ObjectUtils.disposeObject(_txtAwardContent2);
         _txtAwardContent2 = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_bit4);
         _bit4 = null;
         ObjectUtils.disposeObject(btnTab1);
         btnTab1 = null;
         ObjectUtils.disposeObject(btnTab2);
         btnTab2 = null;
         ObjectUtils.disposeObject(btnTab3);
         btnTab3 = null;
         ObjectUtils.disposeObject(btnTab4);
         btnTab4 = null;
         ObjectUtils.disposeObject(btnTab5);
         btnTab5 = null;
         ObjectUtils.disposeObject(btnTab6);
         btnTab6 = null;
         ObjectUtils.disposeObject(hbox);
         hbox = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(awardBox1);
         awardBox1 = null;
         ObjectUtils.disposeObject(awardBox2);
         awardBox2 = null;
         ObjectUtils.disposeObject(awardBox3);
         awardBox3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         awardMap = null;
         super.dispose();
      }
   }
}

