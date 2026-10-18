package cultureactive
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.culture.CultureOrderInfoMsg;
   import flash.events.MouseEvent;
   
   public class CultureActiveSortItem extends Component
   {
      
      private var overBg:Scale9CornerImage;
      
      private var orderText:FilterFrameText;
      
      private var guildNameText:FilterFrameText;
      
      private var serverNameText:FilterFrameText;
      
      private var scoreText:FilterFrameText;
      
      private var lineImage:Image;
      
      public var sortType:int;
      
      private var _data:CultureOrderInfoMsg;
      
      public function CultureActiveSortItem(param1:int)
      {
         super();
         sortType = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         overBg = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortItem.overBg");
         orderText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortItem.orderText");
         guildNameText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortItem.guildNameText");
         serverNameText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortItem.serverNameText");
         scoreText = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortItem.scoreText");
         lineImage = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortItem.lineImage");
         addChild(overBg);
         addChild(orderText);
         addChild(guildNameText);
         addChild(serverNameText);
         addChild(scoreText);
         addChild(lineImage);
         overBg.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__mouseOverHandler);
         addEventListener("rollOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__mouseOverHandler);
         removeEventListener("rollOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            overBg.visible = true;
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         overBg.visible = false;
      }
      
      public function get data() : CultureOrderInfoMsg
      {
         return _data;
      }
      
      public function set data(param1:CultureOrderInfoMsg) : void
      {
         clean();
         _data = param1;
         if(data)
         {
            orderText.text = _data.order + "";
            scoreText.text = _data.totalScore + "";
            switch(sortType - 1)
            {
               case 0:
                  guildNameText.text = _data.consortiaName;
                  guildNameText.x = 110;
                  break;
               case 1:
                  guildNameText.text = _data.consortiaName;
                  serverNameText.text = _data.serverName;
                  break;
               case 2:
                  serverNameText.text = _data.serverName;
                  serverNameText.x = 110;
            }
         }
      }
      
      private function clean() : void
      {
         orderText.text = "";
         guildNameText.text = "";
         serverNameText.text = "";
         scoreText.text = "";
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(overBg);
         overBg = null;
         ObjectUtils.disposeObject(orderText);
         orderText = null;
         ObjectUtils.disposeObject(guildNameText);
         guildNameText = null;
         ObjectUtils.disposeObject(serverNameText);
         serverNameText = null;
         ObjectUtils.disposeObject(scoreText);
         scoreText = null;
         ObjectUtils.disposeObject(lineImage);
         lineImage = null;
         _data = null;
         super.dispose();
      }
   }
}

